import 'package:freezed_annotation/freezed_annotation.dart';

part 'document_item_model.freezed.dart';

part 'document_item_model.g.dart';

@freezed
abstract class DocumentItemModel with _$DocumentItemModel {
  const factory DocumentItemModel({
    @JsonKey(name: 'document_name') final String? documentName,
    @JsonKey(name: 'job_id') final int? jobId,
    @JsonKey(name: 'is_engineer_ack_required')
    final bool? isEngineerAckRequired,
    @JsonKey(name: 'attach_type') final int? attachType,
    @JsonKey(name: 'file_reference') final String? fileReference,
    @JsonKey(name: 'source_rule_document_id') final int? sourceRuleDocumentId,
    @JsonKey(name: 'applied_rule_id') final int? appliedRuleId,
    @JsonKey(name: 'show_on_visit_status_list')
    final String? showOnVisitStatusList,
    @JsonKey(name: 'engineer_read_status') final int? engineerReadStatus,
    final int? id,
    @JsonKey(name: 'tenant_id') final String? tenantId,
    @JsonKey(name: 'created_date_time') final String? createdDateTime,
    @JsonKey(name: 'updated_date_time') final String? updatedDateTime,
    @JsonKey(name: 'is_acknowledged') final bool? isAcknowledged,
    final String? localFilePath,
  }) = _DocumentItemModel;
  factory DocumentItemModel.fromJson(Map<String, dynamic> json) =>
      _$DocumentItemModelFromJson(json);
}

extension DocumentItemModelDb on DocumentItemModel {
  Map<String, dynamic> toDbJson() {
    final json = toJson();
    json['is_engineer_ack_required'] = (isEngineerAckRequired ?? false) ? 1 : 0;
    json['is_acknowledged'] = (isAcknowledged ?? false) ? 1 : 0;
    return json;
  }

  static DocumentItemModel fromDbJson(Map<String, dynamic> json) {
    return DocumentItemModel.fromJson({
      ...json,
      'is_engineer_ack_required': json['is_engineer_ack_required'] == 1,
      'is_acknowledged': json['is_acknowledged'] == 1,
    });
  }
}
