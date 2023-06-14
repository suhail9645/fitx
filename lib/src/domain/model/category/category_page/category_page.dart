import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_page.g.dart';

@JsonSerializable()
class CategoryModelPage extends Equatable {
	final int? count;
	final dynamic next;
	final dynamic previous;
	final List<dynamic>? results;

	const CategoryModelPage({this.count, this.next, this.previous, this.results});

	factory CategoryModelPage.fromJson(Map<String, dynamic> json) {
		return _$CategoryModelPageFromJson(json);
	}

	Map<String, dynamic> toJson() => _$CategoryModelPageToJson(this);

	@override
	List<Object?> get props => [count, next, previous, results];
}
