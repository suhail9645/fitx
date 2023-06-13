import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image_page.g.dart';

@JsonSerializable()
class ImagePage extends Equatable {
  final int? count;
  final dynamic next;
  final dynamic previous;
  final List<dynamic>? results;

  const ImagePage({this.count, this.next, this.previous, this.results});

  factory ImagePage.fromJson(Map<String, dynamic> json) {
    return _$ImagePageFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ImagePageToJson(this);

  @override
  List<Object?> get props => [count, next, previous, results];
}
