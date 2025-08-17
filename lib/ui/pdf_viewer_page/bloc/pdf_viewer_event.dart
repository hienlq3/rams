part of 'pdf_viewer_bloc.dart';

abstract class PdfViewerEvent extends Equatable {
  const PdfViewerEvent();

  @override
  List<Object?> get props => [];
}

class LoadPdfFromDb extends PdfViewerEvent {
  final int documentId;
  const LoadPdfFromDb(this.documentId);

  @override
  List<Object?> get props => [documentId];
}

class SavePdfLocalPath extends PdfViewerEvent {
  final int documentId;
  final String localPath;
  const SavePdfLocalPath(this.documentId, this.localPath);

  @override
  List<Object?> get props => [documentId, localPath];
}

class PdfViewerRetryDownload extends PdfViewerEvent {
  final DocumentItemModel document;
  const PdfViewerRetryDownload(this.document);

  @override
  List<Object?> get props => [document];
}
