import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/models/document_item_model.dart';
import 'package:flutter_application_1/repositories/document_local_repository.dart';
import 'package:flutter_application_1/repositories/document_repository.dart';
import 'package:flutter_application_1/services/fille_saver.dart';
import 'package:flutter_application_1/ui/pdf_viewer_page/pdf_viewer_page.dart';
import 'package:flutter_application_1/ui/rams_documents_page/bloc/rams_documents_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RamsDocumentsPage extends StatelessWidget {
  final int? jobId;
  final String? tenantId;
  final int? engineerId;
  final String? showOnVisitStatusList;
  final int? engineerReadStatus;
  const RamsDocumentsPage({
    super.key,
    this.jobId,
    this.tenantId,
    this.engineerId,
    this.showOnVisitStatusList,
    this.engineerReadStatus,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => RamsDocumentsBloc(
            dio: getIt<Dio>(),
            documentLocalRepository: getIt<DocumentLocalRepository>(),
            documentRepository: getIt<DocumentRepository>(),
          )..add(
            DocumentsFetched(
              jobId: jobId,
              tenantId: tenantId,
              engineerId: engineerId,
              showOnVisitStatusList: showOnVisitStatusList,
              engineerReadStatus: engineerReadStatus,
            ),
          ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('RAMS Documents', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: BlocBuilder<RamsDocumentsBloc, RamsDocumentsState>(
          builder: (context, state) {
            if (state.status == RamsDocumentsStatus.loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.status == RamsDocumentsStatus.error) {
              return Center(
                child: Text(state.errorMessage ?? "Failed to load documents"),
              );
            } else if (state.documents.isEmpty) {
              return Center(child: Text("No documents available"));
            }
            return SafeArea(
              child: ListView.builder(
                itemCount: state.documents.length,
                itemBuilder: (context, index) {
                  final DocumentItemModel doc = state.documents[index];
                  return GestureDetector(
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PDFViewerPage(document: doc),
                          ),
                        ),
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.description, color: Colors.blue),
                        title: Text(
                          doc.documentName ?? 'Unknown Document',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          'Mandatory: ${doc.isEngineerAckRequired == true ? 'Yes' : 'No'}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              doc.isAcknowledged == true
                                  ? Icons.remove_red_eye
                                  : Icons.remove_red_eye_outlined,
                              color:
                                  doc.isAcknowledged == true
                                      ? Colors.green
                                      : Colors.black,
                            ),
                            SizedBox(width: 12),
                            IconButton(
                              icon: Icon(Icons.download, color: Colors.black),
                              onPressed: () async {
                                final filePath =
                                    await FileSaver.saveToDownloads(
                                      File(doc.localFilePath ?? ''),
                                    );
                                if (filePath != null) {
                                  FileSaver.openFile(filePath);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
