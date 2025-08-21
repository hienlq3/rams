part of 'rams_documents_bloc.dart';

enum RamsDocumentsStatus {
  initial,
  loading,
  success,
  error,
  empty,
  downloading,
  downloadSuccess,
  downloadError,
}

final class RamsDocumentsState extends Equatable {
  const RamsDocumentsState({
    this.status = RamsDocumentsStatus.initial,
    this.documents = const <DocumentItemModel>[],
    this.downloadProgress = const {},
    this.errorMessage,
  });
  final RamsDocumentsStatus status;
  final List<DocumentItemModel> documents;

  /// documentId -> progress (0.0 -> 1.0)
  final Map<int, double> downloadProgress;
  final String? errorMessage;

  RamsDocumentsState copyWith({
    RamsDocumentsStatus? status,
    List<DocumentItemModel>? documents,
    Map<int, double>? downloadProgress,
    String? errorMessage,
  }) {
    return RamsDocumentsState(
      status: status ?? this.status,
      documents: documents ?? this.documents,
      downloadProgress: downloadProgress ?? this.downloadProgress,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    documents,
    downloadProgress,
    errorMessage,
  ];
}
