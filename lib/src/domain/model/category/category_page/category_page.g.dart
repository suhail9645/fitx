// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModelPage _$CategoryModelPageFromJson(Map<String, dynamic> json) =>
    CategoryModelPage(
      count: json['count'] as int?,
      next: json['next'] as String?,
      previous: json['previous'],
      results: json['results'] as List<dynamic>?,
    );

Map<String, dynamic> _$CategoryModelPageToJson(CategoryModelPage instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
