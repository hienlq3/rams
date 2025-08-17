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

class DownloadProgressUpdated extends RamsDocumentsEvent {
  final int documentId;
  final double progress;

  const DownloadProgressUpdated(this.documentId, this.progress);

  @override
  List<Object> get props => [documentId, progress];
}

final class PrioritizeDocumentDownload extends RamsDocumentsEvent {
  final int documentId;

  const PrioritizeDocumentDownload(this.documentId);

  @override
  List<Object> get props => [documentId];
}

class LoadFromLocal extends RamsDocumentsEvent {}

class InitDocuments extends RamsDocumentsEvent {}
