import 'package:json_annotation/json_annotation.dart';

part 'additional_movie_info.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class AdditionalMovieInfo {
  final String? title;
  final String? genre;
  final String? description;
  final int? ageRating;
  final int? lengthSeconds;
  final int? lengthMinutes;
  final List<String?>? audioLanguages;
  final String? serienName;

  AdditionalMovieInfo(
      {this.title,
      this.genre,
      this.description,
      this.ageRating,
      this.lengthMinutes,
      this.lengthSeconds,
      this.audioLanguages,
      this.serienName});

  factory AdditionalMovieInfo.fromJson(Map<String, dynamic> json) =>
      _$AdditionalMovieInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AdditionalMovieInfoToJson(this);
}
