// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_movie_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdditionalMovieInfo _$AdditionalMovieInfoFromJson(Map<String, dynamic> json) =>
    AdditionalMovieInfo(
      title: json['Title'] as String?,
      genre: json['Genre'] as String?,
      description: json['Description'] as String?,
      ageRating: json['AgeRating'] as int?,
      lengthMinutes: json['LengthMinutes'] as int?,
      lengthSeconds: json['LengthSeconds'] as int?,
      audioLanguages: (json['AudioLanguages'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      serienName: json['SerienName'] as String?,
    );

Map<String, dynamic> _$AdditionalMovieInfoToJson(
        AdditionalMovieInfo instance) =>
    <String, dynamic>{
      'Title': instance.title,
      'Genre': instance.genre,
      'Description': instance.description,
      'AgeRating': instance.ageRating,
      'LengthSeconds': instance.lengthSeconds,
      'LengthMinutes': instance.lengthMinutes,
      'AudioLanguages': instance.audioLanguages,
      'SerienName': instance.serienName,
    };
