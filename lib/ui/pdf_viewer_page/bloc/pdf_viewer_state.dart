part of 'pdf_viewer_bloc.dart';

enum PdfViewerStatus { initial, ready, missing, loading }

class PdfViewerState extends Equatable {
  final PdfViewerStatus status;
  final String? filePath;
  final String? error;
  final DocumentItemModel? document;

  const PdfViewerState({
    this.status = PdfViewerStatus.initial,
    this.filePath,
    this.error,
    this.document,
  });

  PdfViewerState copyWith({
    PdfViewerStatus? status,
    String? filePath,
    String? error,
    DocumentItemModel? document,
  }) {
    return PdfViewerState(
      status: status ?? this.status,
      filePath: filePath ?? this.filePath,
      error: error ?? this.error,
      document: document ?? this.document,
    );
  }

  @override
  List<Object?> get props => [status, filePath, error, document];
}
