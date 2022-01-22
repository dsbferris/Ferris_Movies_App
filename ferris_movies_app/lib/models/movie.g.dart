// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      name: json['Name'] as String,
      filePath: json['FilePath'] as String,
      fileSize: json['FileSize'] as int,
      info: json['Info'] == null
          ? null
          : AdditionalMovieInfo.fromJson(json['Info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'Name': instance.name,
      'FileSize': instance.fileSize,
      'FilePath': instance.filePath,
      'Info': instance.info,
    };
