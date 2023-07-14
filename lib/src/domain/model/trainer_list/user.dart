import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? id;
  String? name;
  @JsonKey(name: 'profile_picture')
  String? profilePicture;
  String? username;
  @JsonKey(name: 'date_of_birth')
  String? dateOfBirth;
  String? email;
  String? gender;
  @JsonKey(name: 'is_trainer')
  bool? isTrainer;

  User({
    this.id,
    this.name,
    this.profilePicture,
    this.username,
    this.dateOfBirth,
    this.email,
    this.gender,
    this.isTrainer,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
