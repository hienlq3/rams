import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/models/document_item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/repositories/document_local_repository.dart';
import 'package:flutter_application_1/repositories/document_repository.dart';
import 'package:flutter_application_1/services/file_downloader.dart';
import 'package:injectable/injectable.dart';

part 'rams_documents_event.dart';
part 'rams_documents_state.dart';

@injectable
class RamsDocumentsBloc extends Bloc<RamsDocumentsEvent, RamsDocumentsState> {
  late FileDownloader _downloader;

  final Dio dio;

  final DocumentLocalRepository documentLocalRepository;

  final DocumentRepository documentRepository;

  RamsDocumentsBloc({
    required this.dio,
    required this.documentLocalRepository,
    required this.documentRepository,
  }) : super(RamsDocumentsState()) {
    on<DocumentsFetched>(_onDocumentsFetched);
  }

  Future<void> _onDocumentsFetched(
    DocumentsFetched event,
    Emitter<RamsDocumentsState> emit,
  ) async {
    emit(state.copyWith(status: RamsDocumentsStatus.loading));

    final connectivityResult = await Connectivity().checkConnectivity();

    if (!connectivityResult.contains(ConnectivityResult.none)) {
      // Có mạng
      try {
        final List<DocumentItemModel> apiDocuments = await documentRepository
            .documentsFetch(
              jobId: event.jobId ?? -1,
              tenantId: event.tenantId ?? '',
              engineerId: event.engineerId,
              showOnVisitStatusList: event.showOnVisitStatusList,
              engineerReadStatus: event.engineerReadStatus,
            );

        // Load local để so sánh
        final List<DocumentItemModel> localDocuments =
            await documentLocalRepository.loadDocumentsByJobId(
              event.jobId ?? -1,
            );

        // Nếu document mới hơn → update lại local
        for (final apiDoc in apiDocuments) {
          final localDoc = localDocuments.cast<DocumentItemModel?>().firstWhere(
            (d) => d?.id == apiDoc.id,
            orElse: () => null,
          );

          if (localDoc == null) {
            // chưa có → thêm mới
            await documentLocalRepository.saveToLocal([apiDoc]);
          } else {
            // đã có → so sánh updatedDateTime (ví dụ trường updatedDateTime trong model)
            if (apiDoc.updatedDateTime != localDoc.updatedDateTime) {
              await documentLocalRepository.updateDocument(apiDoc);
            }
          }
        }

        // Cấu hình downloader cho các file
        _downloader = FileDownloader(
          dio: dio,
          documentLocalRepository: documentLocalRepository,
        );
        _downloader.configure(documents: apiDocuments);
        _downloader.startDownloads();

        // Lưu toàn bộ documents xuống local (backup sync)
        await documentLocalRepository.saveToLocal(apiDocuments);

        emit(
          state.copyWith(
            documents: apiDocuments,
            status: RamsDocumentsStatus.success,
          ),
        );
      } catch (e) {
        // Nếu API lỗi thì load từ local
        final localDocuments = await documentLocalRepository
            .loadDocumentsByJobId(event.jobId ?? -1);

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
              errorMessage: 'API error and no local data available.',
            ),
          );
        }
      }
    } else {
      // Không có mạng → lấy local
      final documents = await documentLocalRepository.loadDocumentsByJobId(
        event.jobId ?? -1,
      );

      if (documents.isNotEmpty) {
        emit(
          state.copyWith(
            documents: documents,
            status: RamsDocumentsStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: RamsDocumentsStatus.error,
            errorMessage: 'No internet connection and no local data available.',
          ),
        );
      }
    }
  }
}
