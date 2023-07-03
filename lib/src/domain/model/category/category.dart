import 'package:equatable/equatable.dart';
import 'package:fitx/src/domain/model/exercise/exercise.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';


@JsonSerializable()
// ignore: must_be_immutable
class CategoryModel extends Equatable {
	final int? id;
	final String? name;
	final String? description;
	final String? image;
	final String? music;
	@JsonKey(name: 'exercises_count') 
	final int? exercisesCount;
   List<Exercise> ?exercises;
 CategoryModel(this.exercises, {
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
