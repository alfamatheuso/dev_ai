import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'requirement_model.g.dart';

enum RequirementType { functional, nonFunctional, businessRule }

@JsonSerializable()
class RequirementModel {
  final String id;
  final String title;
  final RequirementType type;
  final String description;
  final String justification;
  final DateTime createdAt;
  final List<RequirementVersion> versions;

  RequirementModel({
    String? id,
    required this.title,
    required this.type,
    required this.description,
    required this.justification,
    DateTime? createdAt,
    List<RequirementVersion>? versions,
  })  : id = id ?? Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        versions = versions ?? [];

  factory RequirementModel.fromJson(Map<String, dynamic> json) => _$RequirementModelFromJson(json);
  Map<String, dynamic> toJson() => _$RequirementModelToJson(this);
}

@JsonSerializable()
class RequirementVersion {
  final String modifiedBy;
  final DateTime modifiedAt;
  final String changes;

  RequirementVersion({
    required this.modifiedBy,
    required this.modifiedAt,
    required this.changes,
  });

  factory RequirementVersion.fromJson(Map<String, dynamic> json) => _$RequirementVersionFromJson(json);
  Map<String, dynamic> toJson() => _$RequirementVersionToJson(this);
}