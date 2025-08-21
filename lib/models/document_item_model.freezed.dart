// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DocumentItemModel {

@JsonKey(name: 'document_name') String? get documentName;@JsonKey(name: 'job_id') int? get jobId;@JsonKey(name: 'is_engineer_ack_required') bool? get isEngineerAckRequired;@JsonKey(name: 'attach_type') int? get attachType;@JsonKey(name: 'file_reference') String get fileReference;@JsonKey(name: 'source_rule_document_id') int? get sourceRuleDocumentId;@JsonKey(name: 'applied_rule_id') int? get appliedRuleId;@JsonKey(name: 'show_on_visit_status_list') String? get showOnVisitStatusList;@JsonKey(name: 'engineer_read_status') int? get engineerReadStatus; int? get id;@JsonKey(name: 'tenant_id') String? get tenantId;@JsonKey(name: 'created_date_time') String? get createdDateTime;@JsonKey(name: 'updated_date_time') String? get updatedDateTime;@JsonKey(name: 'is_acknowledged') bool? get isAcknowledged; String get localFilePath;
/// Create a copy of DocumentItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentItemModelCopyWith<DocumentItemModel> get copyWith => _$DocumentItemModelCopyWithImpl<DocumentItemModel>(this as DocumentItemModel, _$identity);

  /// Serializes this DocumentItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentItemModel&&(identical(other.documentName, documentName) || other.documentName == documentName)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.isEngineerAckRequired, isEngineerAckRequired) || other.isEngineerAckRequired == isEngineerAckRequired)&&(identical(other.attachType, attachType) || other.attachType == attachType)&&(identical(other.fileReference, fileReference) || other.fileReference == fileReference)&&(identical(other.sourceRuleDocumentId, sourceRuleDocumentId) || other.sourceRuleDocumentId == sourceRuleDocumentId)&&(identical(other.appliedRuleId, appliedRuleId) || other.appliedRuleId == appliedRuleId)&&(identical(other.showOnVisitStatusList, showOnVisitStatusList) || other.showOnVisitStatusList == showOnVisitStatusList)&&(identical(other.engineerReadStatus, engineerReadStatus) || other.engineerReadStatus == engineerReadStatus)&&(identical(other.id, id) || other.id == id)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.createdDateTime, createdDateTime) || other.createdDateTime == createdDateTime)&&(identical(other.updatedDateTime, updatedDateTime) || other.updatedDateTime == updatedDateTime)&&(identical(other.isAcknowledged, isAcknowledged) || other.isAcknowledged == isAcknowledged)&&(identical(other.localFilePath, localFilePath) || other.localFilePath == localFilePath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,documentName,jobId,isEngineerAckRequired,attachType,fileReference,sourceRuleDocumentId,appliedRuleId,showOnVisitStatusList,engineerReadStatus,id,tenantId,createdDateTime,updatedDateTime,isAcknowledged,localFilePath);

@override
String toString() {
  return 'DocumentItemModel(documentName: $documentName, jobId: $jobId, isEngineerAckRequired: $isEngineerAckRequired, attachType: $attachType, fileReference: $fileReference, sourceRuleDocumentId: $sourceRuleDocumentId, appliedRuleId: $appliedRuleId, showOnVisitStatusList: $showOnVisitStatusList, engineerReadStatus: $engineerReadStatus, id: $id, tenantId: $tenantId, createdDateTime: $createdDateTime, updatedDateTime: $updatedDateTime, isAcknowledged: $isAcknowledged, localFilePath: $localFilePath)';
}


}

/// @nodoc
abstract mixin class $DocumentItemModelCopyWith<$Res>  {
  factory $DocumentItemModelCopyWith(DocumentItemModel value, $Res Function(DocumentItemModel) _then) = _$DocumentItemModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'document_name') String? documentName,@JsonKey(name: 'job_id') int? jobId,@JsonKey(name: 'is_engineer_ack_required') bool? isEngineerAckRequired,@JsonKey(name: 'attach_type') int? attachType,@JsonKey(name: 'file_reference') String fileReference,@JsonKey(name: 'source_rule_document_id') int? sourceRuleDocumentId,@JsonKey(name: 'applied_rule_id') int? appliedRuleId,@JsonKey(name: 'show_on_visit_status_list') String? showOnVisitStatusList,@JsonKey(name: 'engineer_read_status') int? engineerReadStatus, int? id,@JsonKey(name: 'tenant_id') String? tenantId,@JsonKey(name: 'created_date_time') String? createdDateTime,@JsonKey(name: 'updated_date_time') String? updatedDateTime,@JsonKey(name: 'is_acknowledged') bool? isAcknowledged, String localFilePath
});




}
/// @nodoc
class _$DocumentItemModelCopyWithImpl<$Res>
    implements $DocumentItemModelCopyWith<$Res> {
  _$DocumentItemModelCopyWithImpl(this._self, this._then);

  final DocumentItemModel _self;
  final $Res Function(DocumentItemModel) _then;

/// Create a copy of DocumentItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? documentName = freezed,Object? jobId = freezed,Object? isEngineerAckRequired = freezed,Object? attachType = freezed,Object? fileReference = null,Object? sourceRuleDocumentId = freezed,Object? appliedRuleId = freezed,Object? showOnVisitStatusList = freezed,Object? engineerReadStatus = freezed,Object? id = freezed,Object? tenantId = freezed,Object? createdDateTime = freezed,Object? updatedDateTime = freezed,Object? isAcknowledged = freezed,Object? localFilePath = null,}) {
  return _then(_self.copyWith(
documentName: freezed == documentName ? _self.documentName : documentName // ignore: cast_nullable_to_non_nullable
as String?,jobId: freezed == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as int?,isEngineerAckRequired: freezed == isEngineerAckRequired ? _self.isEngineerAckRequired : isEngineerAckRequired // ignore: cast_nullable_to_non_nullable
as bool?,attachType: freezed == attachType ? _self.attachType : attachType // ignore: cast_nullable_to_non_nullable
as int?,fileReference: null == fileReference ? _self.fileReference : fileReference // ignore: cast_nullable_to_non_nullable
as String,sourceRuleDocumentId: freezed == sourceRuleDocumentId ? _self.sourceRuleDocumentId : sourceRuleDocumentId // ignore: cast_nullable_to_non_nullable
as int?,appliedRuleId: freezed == appliedRuleId ? _self.appliedRuleId : appliedRuleId // ignore: cast_nullable_to_non_nullable
as int?,showOnVisitStatusList: freezed == showOnVisitStatusList ? _self.showOnVisitStatusList : showOnVisitStatusList // ignore: cast_nullable_to_non_nullable
as String?,engineerReadStatus: freezed == engineerReadStatus ? _self.engineerReadStatus : engineerReadStatus // ignore: cast_nullable_to_non_nullable
as int?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tenantId: freezed == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String?,createdDateTime: freezed == createdDateTime ? _self.createdDateTime : createdDateTime // ignore: cast_nullable_to_non_nullable
as String?,updatedDateTime: freezed == updatedDateTime ? _self.updatedDateTime : updatedDateTime // ignore: cast_nullable_to_non_nullable
as String?,isAcknowledged: freezed == isAcknowledged ? _self.isAcknowledged : isAcknowledged // ignore: cast_nullable_to_non_nullable
as bool?,localFilePath: null == localFilePath ? _self.localFilePath : localFilePath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DocumentItemModel].
extension DocumentItemModelPatterns on DocumentItemModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DocumentItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DocumentItemModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DocumentItemModel value)  $default,){
final _that = this;
switch (_that) {
case _DocumentItemModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DocumentItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _DocumentItemModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'document_name')  String? documentName, @JsonKey(name: 'job_id')  int? jobId, @JsonKey(name: 'is_engineer_ack_required')  bool? isEngineerAckRequired, @JsonKey(name: 'attach_type')  int? attachType, @JsonKey(name: 'file_reference')  String fileReference, @JsonKey(name: 'source_rule_document_id')  int? sourceRuleDocumentId, @JsonKey(name: 'applied_rule_id')  int? appliedRuleId, @JsonKey(name: 'show_on_visit_status_list')  String? showOnVisitStatusList, @JsonKey(name: 'engineer_read_status')  int? engineerReadStatus,  int? id, @JsonKey(name: 'tenant_id')  String? tenantId, @JsonKey(name: 'created_date_time')  String? createdDateTime, @JsonKey(name: 'updated_date_time')  String? updatedDateTime, @JsonKey(name: 'is_acknowledged')  bool? isAcknowledged,  String localFilePath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DocumentItemModel() when $default != null:
return $default(_that.documentName,_that.jobId,_that.isEngineerAckRequired,_that.attachType,_that.fileReference,_that.sourceRuleDocumentId,_that.appliedRuleId,_that.showOnVisitStatusList,_that.engineerReadStatus,_that.id,_that.tenantId,_that.createdDateTime,_that.updatedDateTime,_that.isAcknowledged,_that.localFilePath);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'document_name')  String? documentName, @JsonKey(name: 'job_id')  int? jobId, @JsonKey(name: 'is_engineer_ack_required')  bool? isEngineerAckRequired, @JsonKey(name: 'attach_type')  int? attachType, @JsonKey(name: 'file_reference')  String fileReference, @JsonKey(name: 'source_rule_document_id')  int? sourceRuleDocumentId, @JsonKey(name: 'applied_rule_id')  int? appliedRuleId, @JsonKey(name: 'show_on_visit_status_list')  String? showOnVisitStatusList, @JsonKey(name: 'engineer_read_status')  int? engineerReadStatus,  int? id, @JsonKey(name: 'tenant_id')  String? tenantId, @JsonKey(name: 'created_date_time')  String? createdDateTime, @JsonKey(name: 'updated_date_time')  String? updatedDateTime, @JsonKey(name: 'is_acknowledged')  bool? isAcknowledged,  String localFilePath)  $default,) {final _that = this;
switch (_that) {
case _DocumentItemModel():
return $default(_that.documentName,_that.jobId,_that.isEngineerAckRequired,_that.attachType,_that.fileReference,_that.sourceRuleDocumentId,_that.appliedRuleId,_that.showOnVisitStatusList,_that.engineerReadStatus,_that.id,_that.tenantId,_that.createdDateTime,_that.updatedDateTime,_that.isAcknowledged,_that.localFilePath);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'document_name')  String? documentName, @JsonKey(name: 'job_id')  int? jobId, @JsonKey(name: 'is_engineer_ack_required')  bool? isEngineerAckRequired, @JsonKey(name: 'attach_type')  int? attachType, @JsonKey(name: 'file_reference')  String fileReference, @JsonKey(name: 'source_rule_document_id')  int? sourceRuleDocumentId, @JsonKey(name: 'applied_rule_id')  int? appliedRuleId, @JsonKey(name: 'show_on_visit_status_list')  String? showOnVisitStatusList, @JsonKey(name: 'engineer_read_status')  int? engineerReadStatus,  int? id, @JsonKey(name: 'tenant_id')  String? tenantId, @JsonKey(name: 'created_date_time')  String? createdDateTime, @JsonKey(name: 'updated_date_time')  String? updatedDateTime, @JsonKey(name: 'is_acknowledged')  bool? isAcknowledged,  String localFilePath)?  $default,) {final _that = this;
switch (_that) {
case _DocumentItemModel() when $default != null:
return $default(_that.documentName,_that.jobId,_that.isEngineerAckRequired,_that.attachType,_that.fileReference,_that.sourceRuleDocumentId,_that.appliedRuleId,_that.showOnVisitStatusList,_that.engineerReadStatus,_that.id,_that.tenantId,_that.createdDateTime,_that.updatedDateTime,_that.isAcknowledged,_that.localFilePath);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DocumentItemModel implements DocumentItemModel {
  const _DocumentItemModel({@JsonKey(name: 'document_name') this.documentName, @JsonKey(name: 'job_id') this.jobId, @JsonKey(name: 'is_engineer_ack_required') this.isEngineerAckRequired, @JsonKey(name: 'attach_type') this.attachType, @JsonKey(name: 'file_reference') this.fileReference = '', @JsonKey(name: 'source_rule_document_id') this.sourceRuleDocumentId, @JsonKey(name: 'applied_rule_id') this.appliedRuleId, @JsonKey(name: 'show_on_visit_status_list') this.showOnVisitStatusList, @JsonKey(name: 'engineer_read_status') this.engineerReadStatus, this.id, @JsonKey(name: 'tenant_id') this.tenantId, @JsonKey(name: 'created_date_time') this.createdDateTime, @JsonKey(name: 'updated_date_time') this.updatedDateTime, @JsonKey(name: 'is_acknowledged') this.isAcknowledged, this.localFilePath = ''});
  factory _DocumentItemModel.fromJson(Map<String, dynamic> json) => _$DocumentItemModelFromJson(json);

@override@JsonKey(name: 'document_name') final  String? documentName;
@override@JsonKey(name: 'job_id') final  int? jobId;
@override@JsonKey(name: 'is_engineer_ack_required') final  bool? isEngineerAckRequired;
@override@JsonKey(name: 'attach_type') final  int? attachType;
@override@JsonKey(name: 'file_reference') final  String fileReference;
@override@JsonKey(name: 'source_rule_document_id') final  int? sourceRuleDocumentId;
@override@JsonKey(name: 'applied_rule_id') final  int? appliedRuleId;
@override@JsonKey(name: 'show_on_visit_status_list') final  String? showOnVisitStatusList;
@override@JsonKey(name: 'engineer_read_status') final  int? engineerReadStatus;
@override final  int? id;
@override@JsonKey(name: 'tenant_id') final  String? tenantId;
@override@JsonKey(name: 'created_date_time') final  String? createdDateTime;
@override@JsonKey(name: 'updated_date_time') final  String? updatedDateTime;
@override@JsonKey(name: 'is_acknowledged') final  bool? isAcknowledged;
@override@JsonKey() final  String localFilePath;

/// Create a copy of DocumentItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentItemModelCopyWith<_DocumentItemModel> get copyWith => __$DocumentItemModelCopyWithImpl<_DocumentItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocumentItemModel&&(identical(other.documentName, documentName) || other.documentName == documentName)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.isEngineerAckRequired, isEngineerAckRequired) || other.isEngineerAckRequired == isEngineerAckRequired)&&(identical(other.attachType, attachType) || other.attachType == attachType)&&(identical(other.fileReference, fileReference) || other.fileReference == fileReference)&&(identical(other.sourceRuleDocumentId, sourceRuleDocumentId) || other.sourceRuleDocumentId == sourceRuleDocumentId)&&(identical(other.appliedRuleId, appliedRuleId) || other.appliedRuleId == appliedRuleId)&&(identical(other.showOnVisitStatusList, showOnVisitStatusList) || other.showOnVisitStatusList == showOnVisitStatusList)&&(identical(other.engineerReadStatus, engineerReadStatus) || other.engineerReadStatus == engineerReadStatus)&&(identical(other.id, id) || other.id == id)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.createdDateTime, createdDateTime) || other.createdDateTime == createdDateTime)&&(identical(other.updatedDateTime, updatedDateTime) || other.updatedDateTime == updatedDateTime)&&(identical(other.isAcknowledged, isAcknowledged) || other.isAcknowledged == isAcknowledged)&&(identical(other.localFilePath, localFilePath) || other.localFilePath == localFilePath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,documentName,jobId,isEngineerAckRequired,attachType,fileReference,sourceRuleDocumentId,appliedRuleId,showOnVisitStatusList,engineerReadStatus,id,tenantId,createdDateTime,updatedDateTime,isAcknowledged,localFilePath);

@override
String toString() {
  return 'DocumentItemModel(documentName: $documentName, jobId: $jobId, isEngineerAckRequired: $isEngineerAckRequired, attachType: $attachType, fileReference: $fileReference, sourceRuleDocumentId: $sourceRuleDocumentId, appliedRuleId: $appliedRuleId, showOnVisitStatusList: $showOnVisitStatusList, engineerReadStatus: $engineerReadStatus, id: $id, tenantId: $tenantId, createdDateTime: $createdDateTime, updatedDateTime: $updatedDateTime, isAcknowledged: $isAcknowledged, localFilePath: $localFilePath)';
}


}

/// @nodoc
abstract mixin class _$DocumentItemModelCopyWith<$Res> implements $DocumentItemModelCopyWith<$Res> {
  factory _$DocumentItemModelCopyWith(_DocumentItemModel value, $Res Function(_DocumentItemModel) _then) = __$DocumentItemModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'document_name') String? documentName,@JsonKey(name: 'job_id') int? jobId,@JsonKey(name: 'is_engineer_ack_required') bool? isEngineerAckRequired,@JsonKey(name: 'attach_type') int? attachType,@JsonKey(name: 'file_reference') String fileReference,@JsonKey(name: 'source_rule_document_id') int? sourceRuleDocumentId,@JsonKey(name: 'applied_rule_id') int? appliedRuleId,@JsonKey(name: 'show_on_visit_status_list') String? showOnVisitStatusList,@JsonKey(name: 'engineer_read_status') int? engineerReadStatus, int? id,@JsonKey(name: 'tenant_id') String? tenantId,@JsonKey(name: 'created_date_time') String? createdDateTime,@JsonKey(name: 'updated_date_time') String? updatedDateTime,@JsonKey(name: 'is_acknowledged') bool? isAcknowledged, String localFilePath
});




}
/// @nodoc
class __$DocumentItemModelCopyWithImpl<$Res>
    implements _$DocumentItemModelCopyWith<$Res> {
  __$DocumentItemModelCopyWithImpl(this._self, this._then);

  final _DocumentItemModel _self;
  final $Res Function(_DocumentItemModel) _then;

/// Create a copy of DocumentItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? documentName = freezed,Object? jobId = freezed,Object? isEngineerAckRequired = freezed,Object? attachType = freezed,Object? fileReference = null,Object? sourceRuleDocumentId = freezed,Object? appliedRuleId = freezed,Object? showOnVisitStatusList = freezed,Object? engineerReadStatus = freezed,Object? id = freezed,Object? tenantId = freezed,Object? createdDateTime = freezed,Object? updatedDateTime = freezed,Object? isAcknowledged = freezed,Object? localFilePath = null,}) {
  return _then(_DocumentItemModel(
documentName: freezed == documentName ? _self.documentName : documentName // ignore: cast_nullable_to_non_nullable
as String?,jobId: freezed == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as int?,isEngineerAckRequired: freezed == isEngineerAckRequired ? _self.isEngineerAckRequired : isEngineerAckRequired // ignore: cast_nullable_to_non_nullable
as bool?,attachType: freezed == attachType ? _self.attachType : attachType // ignore: cast_nullable_to_non_nullable
as int?,fileReference: null == fileReference ? _self.fileReference : fileReference // ignore: cast_nullable_to_non_nullable
as String,sourceRuleDocumentId: freezed == sourceRuleDocumentId ? _self.sourceRuleDocumentId : sourceRuleDocumentId // ignore: cast_nullable_to_non_nullable
as int?,appliedRuleId: freezed == appliedRuleId ? _self.appliedRuleId : appliedRuleId // ignore: cast_nullable_to_non_nullable
as int?,showOnVisitStatusList: freezed == showOnVisitStatusList ? _self.showOnVisitStatusList : showOnVisitStatusList // ignore: cast_nullable_to_non_nullable
as String?,engineerReadStatus: freezed == engineerReadStatus ? _self.engineerReadStatus : engineerReadStatus // ignore: cast_nullable_to_non_nullable
as int?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,tenantId: freezed == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String?,createdDateTime: freezed == createdDateTime ? _self.createdDateTime : createdDateTime // ignore: cast_nullable_to_non_nullable
as String?,updatedDateTime: freezed == updatedDateTime ? _self.updatedDateTime : updatedDateTime // ignore: cast_nullable_to_non_nullable
as String?,isAcknowledged: freezed == isAcknowledged ? _self.isAcknowledged : isAcknowledged // ignore: cast_nullable_to_non_nullable
as bool?,localFilePath: null == localFilePath ? _self.localFilePath : localFilePath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
