import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class CategoryModel extends Equatable {
	final int? id;
	final String? name;
	final String? description;
	final String? image;
	final String? music;
	@JsonKey(name: 'exercises_count') 
	final int? exercisesCount;

	const CategoryModel({
		this.id, 
		this.name, 
		this.description, 
		this.image, 
		this.music, 
		this.exercisesCount, 
	});

	factory CategoryModel.fromJson(Map<String, dynamic> json) {
		return _$CategoryModelFromJson(json);
	}

	Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

	@override
	List<Object?> get props {
		return [
				id,
				name,
				description,
				image,
				music,
				exercisesCount,
		];
	}
}
