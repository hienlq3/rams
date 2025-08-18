import 'dart:developer';

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
    log(widget.document.toString(), name: 'PDFViewerPage');
    return BlocProvider(
      create:
          (context) => PdfViewerBloc(
            documentLocalRepository: getIt<DocumentLocalRepository>(),
            dio: getIt<Dio>(),
          )..add(LoadPdfFromDb(widget.document.id ?? -1)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.document.documentName ?? 'Unknown Document',
            style: TextStyle(color: Colors.black),
          ),
          leading: BackButton(color: Colors.green),
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [_buildHeader(), Expanded(child: _buildPDFContent())],
          ),
        ),
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(
            'JOB NO: ',
            widget.document.jobId?.toString() ?? 'Unknown',
          ),
          // _buildInfoRow('VISIT ID: ', widget.document.visitId ?? 'Unknown'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.black),
        children: [
          TextSpan(
            text: label,
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }

  Widget _buildPDFContent() {
    return BlocBuilder<PdfViewerBloc, PdfViewerState>(
      builder: (context, state) {
        if (state.status == PdfViewerStatus.ready) {
          return PDFView(filePath: state.filePath);
        }

        if (state.status == PdfViewerStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == PdfViewerStatus.missing) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("File not found"),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  icon: const Icon(Icons.refresh),
                  label: const Text("Retry"),
                  onPressed: () {
                    context.read<PdfViewerBloc>().add(
                      PdfViewerRetryDownload(widget.document),
                    );
                  },
                ),
              ],
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildBottomBar() {
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: true,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  child: Text('Cancel'),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed:
                      widget.document.isAcknowledged == true
                          ? null
                          : () => Navigator.pop(context),
                  child: Text('Acknowledge'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
