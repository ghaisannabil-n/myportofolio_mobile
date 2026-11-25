import 'package:json_annotation/json_annotation.dart';

part 'experience.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Experience {
  const Experience({
    required this.role,
    required this.organization,
    required this.startDate,
    this.endDate = '',
    this.description = '',
    this.id,
  });

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);

  @JsonKey(includeToJson: false)
  final String? id;
  final String role;
  final String organization;
  final String startDate;

  @JsonKey(defaultValue: '')
  final String endDate;

  @JsonKey(defaultValue: '')
  final String description;

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}