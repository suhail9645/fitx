import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise_page.g.dart';

@JsonSerializable()
class ExercisePage extends Equatable {
  final int? count;
  final dynamic next;
  final dynamic previous;
  final List<dynamic>? results;

  const ExercisePage({this.count, this.next, this.previous, this.results});

  factory ExercisePage.fromJson(Map<String, dynamic> json) {
    return _$ExercisePageFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ExercisePageToJson(this);

  @override
  List<Object?> get props => [count, next, previous, results];
}
