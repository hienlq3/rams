part of 'rams_documents_bloc.dart';

sealed class RamsDocumentsEvent extends Equatable {
  const RamsDocumentsEvent();

  @override
  List<dynamic> get props => [];
}

final class DocumentsFetched extends RamsDocumentsEvent {
  final int? jobId;
  final String? tenantId;
  final int? engineerId;
  final String? showOnVisitStatusList;
  final int? engineerReadStatus;

  const DocumentsFetched({
    this.jobId,
    this.tenantId,
    this.engineerId,
    this.showOnVisitStatusList,
    this.engineerReadStatus,
  });

  @override
  List<Object?> get props => [
    jobId,
    tenantId,
    engineerId,
    showOnVisitStatusList,
    engineerReadStatus,
  ];
}

final class DocumentsDownloaded extends RamsDocumentsEvent {
  final int? documentId;

  const DocumentsDownloaded(this.documentId);

  @override
  List<Object?> get props => [documentId];
}

class PdfViewerDownloadCompleted extends RamsDocumentsEvent {
  final int documentId;
  final String? error;
  const PdfViewerDownloadCompleted(this.documentId, {this.error});

  @override
  List<Object?> get props => [documentId, error];
}
