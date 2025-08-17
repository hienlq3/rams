import 'package:flutter_application_1/services/base_service.dart';
import 'package:injectable/injectable.dart';

@singleton
class DocumentService {
  DocumentService({required BaseService baseService})
    : _baseService = baseService;
  final BaseService _baseService;

  Future<Map<String, dynamic>?> fetchDocuments({
    required int jobId,
    required String tenantId,
    int? engineerId,
    String? showOnVisitStatusList,
    int? engineerReadStatus,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'tenant_id': tenantId,
        if (engineerId != null) 'engineer_id': engineerId,
        if (showOnVisitStatusList != null)
          'show_on_visit_status_list': showOnVisitStatusList,
        if (engineerReadStatus != null)
          'engineer_read_status': engineerReadStatus,
      };

      final response = await _baseService.get(
        '/api/mobile/jobs/$jobId/documents',
        queryParameters: queryParams,
      );

      return response.data;
    } catch (e) {
      throw Exception('Error fetching documents: $e');
    }
  }
}
