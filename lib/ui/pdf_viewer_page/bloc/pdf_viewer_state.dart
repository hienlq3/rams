part of 'pdf_viewer_bloc.dart';

enum PdfViewerStatus { initial, ready, missing, loading }

class PdfViewerState extends Equatable {
  final PdfViewerStatus status;
  final String? filePath;
  final String? error;

  const PdfViewerState({
    this.status = PdfViewerStatus.initial,
    this.filePath,
    this.error,
  });

  PdfViewerState copyWith({
    PdfViewerStatus? status,
    String? filePath,
    String? error,
  }) {
    return PdfViewerState(
      status: status ?? this.status,
      filePath: filePath ?? this.filePath,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, filePath, error];
}
