import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/models/document_item_model.dart';
import 'package:flutter_application_1/repositories/document_local_repository.dart';
import 'package:flutter_application_1/ui/pdf_viewer_page/bloc/pdf_viewer_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewerPage extends StatefulWidget {
  final DocumentItemModel document;

  const PDFViewerPage({super.key, required this.document});

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => PdfViewerBloc(
            documentLocalRepository: getIt<DocumentLocalRepository>(),
            dio: getIt<Dio>(),
            document: widget.document,
          )..add(LoadPdfFromDb(widget.document.id ?? -1)),
      child: BlocBuilder<PdfViewerBloc, PdfViewerState>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async => _canClose(context, state),
            child: Scaffold(
              appBar: _buildAppBar(),
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(),
                    Expanded(child: _buildPDFContent(state)),
                  ],
                ),
              ),
              bottomNavigationBar: _buildBottomBar(context, state),
            ),
          );
        },
      ),
    );
  }

  /// --- UI BUILDERS ---

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        widget.document.documentName ?? 'Unknown Document',
        style: const TextStyle(color: Colors.black),
      ),
      leading: const BackButton(color: Colors.green),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: _buildInfoRow(
        'JOB NO: ',
        widget.document.jobId?.toString() ?? 'Unknown',
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black),
        children: [
          TextSpan(
            text: label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }

  Widget _buildPDFContent(PdfViewerState state) {
    switch (state.status) {
      case PdfViewerStatus.ready:
        return PDFView(filePath: state.filePath);

      case PdfViewerStatus.loading:
        return const Center(child: CircularProgressIndicator());

      case PdfViewerStatus.missing:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(state.error ?? 'File not found'),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text("Retry"),
                onPressed:
                    () => context.read<PdfViewerBloc>().add(
                      PdfViewerRetryDownload(widget.document),
                    ),
              ),
            ],
          ),
        );

      default:
        return const Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildBottomBar(BuildContext context, PdfViewerState state) {
    final requiresAck = state.document?.isEngineerAckRequired == true;
    final isAcked = state.document?.isAcknowledged == true;

    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  child: const Text('Close'),
                  onPressed: () => _handleClose(context, state),
                ),
              ),
              if (requiresAck && !isAcked) ...[
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<PdfViewerBloc>().add(
                        AcknowledgeDocument(widget.document.id ?? -1),
                      );
                      Navigator.pop(context);
                      _showSnack(context, 'Acknowledged successfully.');
                    },
                    child: const Text('Acknowledge'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// --- LOGIC HELPERS ---

  Future<bool> _canClose(BuildContext context, PdfViewerState state) async {
    if (state.document?.isEngineerAckRequired == true &&
        state.document?.isAcknowledged == false) {
      _showSnack(context, 'You must acknowledge this document to proceed.');
      return false;
    }
    return true;
  }

  void _handleClose(BuildContext context, PdfViewerState state) {
    _canClose(context, state).then((canClose) {
      if (canClose) Navigator.pop(context);
    });
  }

  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
