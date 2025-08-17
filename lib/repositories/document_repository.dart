import 'package:flutter_application_1/models/document_item_model.dart';
import 'package:flutter_application_1/services/document_service.dart';
import 'package:injectable/injectable.dart';

@singleton
class DocumentRepository {
  DocumentRepository({required DocumentService documentService})
    : _documentService = documentService;
  final DocumentService _documentService;

  Future<List<DocumentItemModel>> documentsFetch({
    required int jobId,
    required String tenantId,
    int? engineerId,
    String? showOnVisitStatusList,
    int? engineerReadStatus,
  }) async {
    try {
      final responseJson = await _documentService.fetchDocuments(
        jobId: jobId,
        tenantId: tenantId,
        engineerId: engineerId,
        showOnVisitStatusList: showOnVisitStatusList,
        engineerReadStatus: engineerReadStatus,
      );
      if (responseJson != null) {
        return (responseJson['items'] as List)
            .map((doc) => DocumentItemModel.fromJson(doc))
            .toList();
      }
      return <DocumentItemModel>[];
    } on Exception {
      rethrow;
    }
  }
}
