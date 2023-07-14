import 'package:json_annotation/json_annotation.dart';

import 'result.dart';

part 'trainer_list.g.dart';

@JsonSerializable()
class TrainerList {
  int? count;
  dynamic next;
  dynamic previous;
  List<Result>? results;

  TrainerList({this.count, this.next, this.previous, this.results});

  factory TrainerList.fromJson(Map<String, dynamic> json) {
    return _$TrainerListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TrainerListToJson(this);
}
