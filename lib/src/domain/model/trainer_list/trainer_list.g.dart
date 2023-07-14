// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trainer_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrainerList _$TrainerListFromJson(Map<String, dynamic> json) => TrainerList(
      count: json['count'] as int?,
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TrainerListToJson(TrainerList instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
