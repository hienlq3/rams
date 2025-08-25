import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter_application_1/models/document_item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/repositories/document_local_repository.dart';
import 'package:flutter_application_1/repositories/document_repository.dart';
import 'package:flutter_application_1/services/file_downloader.dart';
import 'package:injectable/injectable.dart';
import 'package:open_filex/open_filex.dart';

part 'rams_documents_event.dart';
part 'rams_documents_state.dart';

@injectable
class RamsDocumentsBloc extends Bloc<RamsDocumentsEvent, RamsDocumentsState> {
  FileDownloader? _downloader;

  final Dio dio;
  final DocumentLocalRepository documentLocalRepository;
  final DocumentRepository documentRepository;

  RamsDocumentsBloc({
    required this.dio,
    required this.documentLocalRepository,
    required this.documentRepository,
  }) : super(RamsDocumentsState()) {
    on<DocumentsFetched>(_onDocumentsFetched);
    on<DocumentsDownloaded>(_onDocumentsDownloaded);
    on<PdfViewerDownloadCompleted>((event, emit) async {
      final doc = await documentLocalRepository.loadDocumentById(
        event.documentId,
      );
      if ((await doc?.hasLocalFile) == true) {
        emit(state.copyWith(status: RamsDocumentsStatus.downloadSuccess));
      } else {
        emit(
          state.copyWith(
            status: RamsDocumentsStatus.downloadError,
            errorMessage: event.error ?? 'File not found',
          ),
        );
      }
    });
  }

  // ================== FETCH DOCUMENTS ==================
  Future<void> _onDocumentsFetched(
    DocumentsFetched event,
    Emitter<RamsDocumentsState> emit,
  ) async {
    if (state.status == RamsDocumentsStatus.initial) {
      emit(state.copyWith(status: RamsDocumentsStatus.loading));
    }

    final connectivityResult = await Connectivity().checkConnectivity();
    final hasInternet = !connectivityResult.contains(ConnectivityResult.none);

    if (hasInternet) {
      await _fetchDocumentsOnline(event, emit);
    } else {
      await _fetchDocumentsOffline(event, emit);
    }
  }

  Future<void> _fetchDocumentsOnline(
    DocumentsFetched event,
    Emitter<RamsDocumentsState> emit,
  ) async {
    try {
      final apiDocuments = await documentRepository.documentsFetch(
        jobId: event.jobId ?? -1,
        tenantId: event.tenantId ?? '',
        engineerId: event.engineerId,
        showOnVisitStatusList: event.showOnVisitStatusList,
        engineerReadStatus: event.engineerReadStatus,
      );

      await _syncDocumentsWithLocal(
        apiDocuments,
        event.jobId ?? -1,
        event.tenantId ?? '',
      );

      _downloader = FileDownloader(
        dio: dio,
        documentLocalRepository: documentLocalRepository,
      );
      _downloader?.configure(documents: apiDocuments);
      _downloader?.startDownloads();

      emit(
        state.copyWith(
          documents: apiDocuments,
          status: RamsDocumentsStatus.success,
        ),
      );
    } catch (_) {
      await _fetchDocumentsOffline(event, emit, apiFailed: true);
    }
  }

  Future<void> _fetchDocumentsOffline(
    DocumentsFetched event,
    Emitter<RamsDocumentsState> emit, {
    bool apiFailed = false,
  }) async {
    final localDocuments = await documentLocalRepository
        .loadDocumentsByJobIdAndTenant(event.jobId ?? -1, event.tenantId ?? '');

    log('localDocuments: ${localDocuments.toString()}');

    log('unsyncedDocs: ${documentLocalRepository.unsyncedDocs.toString()}');

    if (localDocuments.isNotEmpty) {
      emit(
        state.copyWith(
          documents: localDocuments,
          status: RamsDocumentsStatus.success,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: RamsDocumentsStatus.error,
          errorMessage:
              apiFailed
                  ? 'API error and no local data available.'
                  : 'No internet connection and no local data available.',
        ),
      );
    }
  }

  Future<void> _syncDocumentsWithLocal(
    List<DocumentItemModel> apiDocuments,
    int jobId,
    String tenantId,
  ) async {
    final localDocuments = await documentLocalRepository
        .loadDocumentsByJobIdAndTenant(jobId, tenantId);

    for (final apiDoc in apiDocuments) {
      final localDoc = localDocuments.cast<DocumentItemModel?>().firstWhere(
        (d) => d?.id == apiDoc.id,
        orElse: () => null,
      );

      if (localDoc == null) {
        await documentLocalRepository.saveToLocal([apiDoc]);
      } else if (apiDoc.updatedDateTime != localDoc.updatedDateTime) {
        await documentLocalRepository.updateDocument(apiDoc);
      }
    }

    // Backup sync
    await documentLocalRepository.saveToLocal(apiDocuments);
  }

  // ================== DOWNLOAD DOCUMENT ==================
  Future<void> _onDocumentsDownloaded(
    DocumentsDownloaded event,
    Emitter<RamsDocumentsState> emit,
  ) async {
    emit(state.copyWith(status: RamsDocumentsStatus.downloading));

    final documentId = event.documentId ?? -1;
    DocumentItemModel? document = await documentLocalRepository
        .loadDocumentById(documentId);
    if (document == null) {
      emit(
        state.copyWith(
          status: RamsDocumentsStatus.error,
          errorMessage: 'Document not found',
        ),
      );
      return;
    }

    try {
      if (await document.hasLocalFile) {
        await _copyDocumentToDownload(document);
      } else {
        _downloader ??= FileDownloader(
          dio: dio,
          documentLocalRepository: documentLocalRepository,
        );
        _downloader?.configure(
          documents: [document],
          onProgress: (id, progress, {error}) {
            if (progress == 1.0) {
              add(PdfViewerDownloadCompleted(document.id ?? -1));
            } else if (progress == -1.0) {
              add(PdfViewerDownloadCompleted(document.id ?? -1, error: error));
            }
          },
        );
        await _downloader?.startDownloads(copyToDownloads: true);
      }
    } catch (error, trace) {
      onError(error, trace);
      emit(
        state.copyWith(
          status: RamsDocumentsStatus.downloadError,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> _copyDocumentToDownload(DocumentItemModel document) async {
    try {
      final localFile = File(document.localFilePath);

      final downloadPath = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOAD,
      );

      final filename = getFileNameFromReference(document.fileReference);

      if (filename == null) {
        throw 'Invalid file reference';
      }
      final sanitizedFileName = '${document.id}-${sanitizeFileName(filename)}';
      final filepath = "$downloadPath/$sanitizedFileName";

      await localFile.copy(filepath);

      // Mở file nếu muốn:
      await OpenFilex.open(filepath);
    } catch (e) {
      log("Error copying file: $e");
      rethrow;
    }
  }

  // ================== UTILS ==================
  String sanitizeFileName(String name) {
    return name.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
  }

  String? getFileNameFromReference(String? fileReference) {
    if (fileReference == null || fileReference.trim().isEmpty) {
      return null; // or return a default like "unknown.txt"
    }

    final uri = Uri.tryParse(fileReference);
    if (uri == null || uri.pathSegments.isEmpty) {
      return null;
    }

    return uri.pathSegments.last;
  }
}
