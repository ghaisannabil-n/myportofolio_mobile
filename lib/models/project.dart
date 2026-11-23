import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

/// Portfolio project synchronized with the Django REST Framework API.
@JsonSerializable(fieldRename: FieldRename.snake)
class Project {
  const Project({
    this.id,
    required this.title,
    required this.description,
    required this.techStack,
    required this.projectUrl,
    this.projectImageUrl = '',
    // TODO: Add required parameters for description, techStack, and projectUrl
    // TODO: Add optional parameter projectImageUrl (default '') and nullable id
  });

  // TODO: Implement factory Project.fromJson(Map<String, dynamic> json)
  // delegating to _$ProjectFromJson(json)
  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  @JsonKey(includeToJson: false)
  final String? id;
  final String title;
  final String description;
  final String techStack;
  final String projectUrl;
  @JsonKey(defaultValue: '')
  final String projectImageUrl;

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
  // TODO: Declare final String fields for description, techStack, projectUrl,
  // and projectImageUrl (annotated with @JsonKey(defaultValue: ''))

  // TODO: Implement Map<String, dynamic> toJson() delegating to _$ProjectToJson(this)
}
