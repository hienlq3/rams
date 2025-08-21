// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DocumentItemModel _$DocumentItemModelFromJson(Map<String, dynamic> json) =>
    _DocumentItemModel(
      documentName: json['document_name'] as String?,
      jobId: (json['job_id'] as num?)?.toInt(),
      isEngineerAckRequired: json['is_engineer_ack_required'] as bool?,
      attachType: (json['attach_type'] as num?)?.toInt(),
      fileReference: json['file_reference'] as String? ?? '',
      sourceRuleDocumentId: (json['source_rule_document_id'] as num?)?.toInt(),
      appliedRuleId: (json['applied_rule_id'] as num?)?.toInt(),
      showOnVisitStatusList: json['show_on_visit_status_list'] as String?,
      engineerReadStatus: (json['engineer_read_status'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      tenantId: json['tenant_id'] as String?,
      createdDateTime: json['created_date_time'] as String?,
      updatedDateTime: json['updated_date_time'] as String?,
      isAcknowledged: json['is_acknowledged'] as bool?,
      localFilePath: json['localFilePath'] as String? ?? '',
    );

Map<String, dynamic> _$DocumentItemModelToJson(_DocumentItemModel instance) =>
    <String, dynamic>{
      'document_name': instance.documentName,
      'job_id': instance.jobId,
      'is_engineer_ack_required': instance.isEngineerAckRequired,
      'attach_type': instance.attachType,
      'file_reference': instance.fileReference,
      'source_rule_document_id': instance.sourceRuleDocumentId,
      'applied_rule_id': instance.appliedRuleId,
      'show_on_visit_status_list': instance.showOnVisitStatusList,
      'engineer_read_status': instance.engineerReadStatus,
      'id': instance.id,
      'tenant_id': instance.tenantId,
      'created_date_time': instance.createdDateTime,
      'updated_date_time': instance.updatedDateTime,
      'is_acknowledged': instance.isAcknowledged,
      'localFilePath': instance.localFilePath,
    };
