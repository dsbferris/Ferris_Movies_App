import 'package:json_annotation/json_annotation.dart';
import 'additional_movie_info.dart';

part 'movie.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class Movie {
  final String name;
  final int fileSize;
  final String filePath;
  final AdditionalMovieInfo? info;

  Movie(
      {required this.name,
      required this.filePath,
      required this.fileSize,
      this.info});

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);

  String getVideoFilePath() {
    var baseString = "smb://ferris:schussl0@";
    var path =
        filePath.replaceAll(RegExp(r'\\'), "/").replaceFirst(RegExp("//"), "");
    return baseString + path;
  }
}
