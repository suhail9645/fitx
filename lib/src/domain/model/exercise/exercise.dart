import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise.g.dart';

@JsonSerializable()
class Exercise extends Equatable {
  final int? id;
  final String name;
  final String description;
  final dynamic demo;
  final int? count;
  final dynamic duration;
  @JsonKey(name: 'burn_calorie')
  final int burnCalorie;
  @JsonKey(name: 'video_link')
  final String videoLink;
  @JsonKey(name: 'focused_area')
  final String focusedArea;

  const Exercise({
    required this.id,
    required this.name,
    required this.description,
    this.demo,
    this.count,
    this.duration,
    required this.burnCalorie,
    required this.videoLink,
    required this.focusedArea,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return _$ExerciseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ExerciseToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      name,
      description,
      demo,
      count,
      duration,
      burnCalorie,
      videoLink,
      focusedArea,
    ];
  }
}
