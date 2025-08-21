import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/models/document_item_model.dart';
import 'package:flutter_application_1/repositories/document_local_repository.dart';
import 'package:flutter_application_1/repositories/document_repository.dart';
import 'package:flutter_application_1/ui/pdf_viewer_page/pdf_viewer_page.dart';
import 'package:flutter_application_1/ui/rams_documents_page/bloc/rams_documents_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RamsDocumentsPage extends StatefulWidget {
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
  State<RamsDocumentsPage> createState() => _RamsDocumentsPageState();
}

class _RamsDocumentsPageState extends State<RamsDocumentsPage> {
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
              jobId: widget.jobId,
              tenantId: widget.tenantId,
              engineerId: widget.engineerId,
              showOnVisitStatusList: widget.showOnVisitStatusList,
              engineerReadStatus: widget.engineerReadStatus,
            ),
          ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('RAMS Documents', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: BlocConsumer<RamsDocumentsBloc, RamsDocumentsState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (!mounted) return; // ✅ tránh lỗi async gap
            if (state.status == RamsDocumentsStatus.downloadSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Download completed successfully')),
              );
            } else if (state.status == RamsDocumentsStatus.downloadError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Download failed: ${state.errorMessage}'),
                ),
              );
            }
          },
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
              child: Column(
                children: [
                  // Header row
                  Card(
                    margin: EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 6.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        spacing: 8.0,
                        children: [
                          Expanded(flex: 2, child: Text("Document Name")),
                          Expanded(child: Text('Mandatory')),
                          Text('Action'),
                        ],
                      ),
                    ),
                  ),

                  // List documents
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.documents.length,
                      itemBuilder: (context, index) {
                        final DocumentItemModel doc = state.documents[index];
                        return GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => PDFViewerPage(document: doc),
                              ),
                            );

                            if (!mounted) {
                              return; // ✅ check context trước khi gọi bloc
                            }
                            context.read<RamsDocumentsBloc>().add(
                              DocumentsFetched(
                                jobId: widget.jobId,
                                tenantId: widget.tenantId,
                                engineerId: widget.engineerId,
                                showOnVisitStatusList:
                                    widget.showOnVisitStatusList,
                                engineerReadStatus: widget.engineerReadStatus,
                              ),
                            );
                          },
                          child: Card(
                            margin: EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 6.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                spacing: 8.0,
                                children: [
                                  Icon(Icons.description, color: Colors.blue),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      doc.documentName ?? 'Unknown Document',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      softWrap: false,
                                    ),
                                  ),
                                  Text(
                                    doc.isEngineerAckRequired == true
                                        ? 'Yes'
                                        : 'No',
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      color:
                                          doc.isAcknowledged == true
                                              ? Colors.green
                                              : Colors.black,
                                    ),
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    onPressed:
                                        () => context
                                            .read<RamsDocumentsBloc>()
                                            .add(DocumentsDownloaded(doc.id)),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.download,
                                      color: Colors.black,
                                    ),
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    onPressed:
                                        () => context
                                            .read<RamsDocumentsBloc>()
                                            .add(DocumentsDownloaded(doc.id)),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.check),
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                    onPressed:
                                        () => context
                                            .read<RamsDocumentsBloc>()
                                            .add(DocumentsDownloaded(doc.id)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
