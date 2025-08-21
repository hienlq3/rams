import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/models/document_item_model.dart';
import 'package:flutter_application_1/repositories/document_local_repository.dart';
import 'package:flutter_application_1/services/file_downloader.dart';

part 'pdf_viewer_event.dart';
part 'pdf_viewer_state.dart';

class PdfViewerBloc extends Bloc<PdfViewerEvent, PdfViewerState> {
  final DocumentLocalRepository documentLocalRepository;
  late FileDownloader _downloader;
  final Dio dio;

  PdfViewerBloc({required this.documentLocalRepository, required this.dio})
    : super(const PdfViewerState()) {
    on<LoadPdfFromDb>(_onLoadPdfFromDb);
    on<SavePdfLocalPath>(_onSavePdfLocalPath);
    on<PdfViewerRetryDownload>(_onRetryDownload);
    on<PdfViewerDownloadCompleted>((event, emit) async {
      final doc = await documentLocalRepository.loadDocumentById(
        event.documentId,
      );
      if ((await doc?.hasLocalFile) == true) {
        emit(
          state.copyWith(
            status: PdfViewerStatus.ready,
            filePath: doc?.localFilePath,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: PdfViewerStatus.missing,
            error: event.error ?? 'File not found',
          ),
        );
      }
    });
  }

  Future<void> _onLoadPdfFromDb(
    LoadPdfFromDb event,
    Emitter<PdfViewerState> emit,
  ) async {
    emit(state.copyWith(status: PdfViewerStatus.loading, error: null));
    try {
      final doc = await documentLocalRepository.loadDocumentById(
        event.documentId,
      );
      await _checkIfFileIsReady(localFilePath: doc?.localFilePath, emit: emit);
      emit(state.copyWith(filePath: doc?.localFilePath));
    } catch (e) {
      emit(
        state.copyWith(status: PdfViewerStatus.missing, error: e.toString()),
      );
    }
  }

  Future<void> _onSavePdfLocalPath(
    SavePdfLocalPath event,
    Emitter<PdfViewerState> emit,
  ) async {
    try {
      await documentLocalRepository.updateDocumentLocalPath(
        event.documentId,
        event.localPath,
      );
      emit(state.copyWith(filePath: event.localPath));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _checkIfFileIsReady({
    String? localFilePath,
    required Emitter<PdfViewerState> emit,
  }) async {
    final path = localFilePath;

    if (path == null) {
      emit(state.copyWith(status: PdfViewerStatus.missing));
      return;
    }

    final file = File(path);
    if (await file.exists()) {
      emit(state.copyWith(status: PdfViewerStatus.ready));
    } else {
      emit(state.copyWith(status: PdfViewerStatus.missing));
    }
  }

  Future<void> _onRetryDownload(
    PdfViewerRetryDownload event,
    Emitter<PdfViewerState> emit,
  ) async {
    emit(state.copyWith(status: PdfViewerStatus.loading, error: null));
    try {
      final document = event.document;
      _downloader = FileDownloader(
        dio: dio,
        documentLocalRepository: documentLocalRepository,
      );

      _downloader.configure(
        documents: [document],
        onProgress: (id, progress, {error}) {
          if (progress == 1.0) {
            add(PdfViewerDownloadCompleted(document.id ?? -1));
          } else if (progress == -1.0) {
            add(PdfViewerDownloadCompleted(document.id ?? -1, error: error));
          }
        },
      );

      await _downloader.startDownloads();
    } catch (e) {
      emit(
        state.copyWith(status: PdfViewerStatus.missing, error: e.toString()),
      );
    }
  }
}
