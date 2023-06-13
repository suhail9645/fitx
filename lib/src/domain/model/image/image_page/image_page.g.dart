// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImagePage _$ImagePageFromJson(Map<String, dynamic> json) => ImagePage(
      count: json['count'] as int?,
      next: json['next'],
      previous: json['previous'],
      results: json['results'] as List<dynamic>?,
    );

Map<String, dynamic> _$ImagePageToJson(ImagePage instance) => <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
