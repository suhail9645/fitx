import 'package:json_annotation/json_annotation.dart';

import 'certificate.dart';
import 'user.dart';

part 'result.g.dart';

@JsonSerializable()
class Result {
  int? id;
  User? user;
  String? phone;
  List<Certificate>? certificates;
  String? experience;

  Result({
    this.id,
    this.user,
    this.phone,
    this.certificates,
    this.experience,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return _$ResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
