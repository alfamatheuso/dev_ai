import 'package:json_annotation/json_annotation.dart';

part 'analyzer_model.g.dart';

@JsonSerializable()
class AnalyzerRequest {
  final String projectName;
  final String repositoryLink;
  final String analysisType;
  final String? apiKey;

  AnalyzerRequest({
    required this.projectName,
    required this.repositoryLink,
    required this.analysisType,
    this.apiKey,
  });

  factory AnalyzerRequest.fromJson(Map<String, dynamic> json) => _$AnalyzerRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AnalyzerRequestToJson(this);
}