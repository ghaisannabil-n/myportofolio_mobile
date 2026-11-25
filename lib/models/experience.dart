import 'package:json_annotation/json_annotation.dart';

part 'experience.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Experience {
  const Experience({
    required this.title,
    required this.description,
    required this.category,
    this.id,
    this.thumbnail = '',
    this.categoryDisplay = '',
    this.isOngoing = false,
    this.starCount = 0,
    this.isStarred = false,
    this.experienceImg = '',
    this.starredByNames = '',
  });

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);

  @JsonKey(includeToJson: false)
  final String? id;
  final String title;
  final String description;
  final String category;

  @JsonKey(defaultValue: '')
  final String thumbnail;

  @JsonKey(includeToJson: false, defaultValue: '')
  final String categoryDisplay;

  @JsonKey(includeToJson: false, defaultValue: false)
  final bool isOngoing;

  @JsonKey(includeToJson: false, defaultValue: 0)
  final int starCount;

  @JsonKey(includeToJson: false, defaultValue: false)
  final bool isStarred;

  @JsonKey(includeToJson: false, defaultValue: '')
  final String experienceImg;

  @JsonKey(includeToJson: false, defaultValue: '')
  final String starredByNames;

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}
