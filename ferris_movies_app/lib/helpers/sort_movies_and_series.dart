
import 'dart:collection';

import 'package:ferris_movies_app/models/movie.dart';

void sortMoviesAndSeries(List<Movie> allMovies) {
  List<String?> seriesList = allMovies
      .where((element) => element.info?.serienName != null)
      .map((e) => e.info?.serienName)
      .toSet() //toSet for only distinct values
      .toList()
    ..sort();

  var seriesMap = HashMap<String, List<Movie>>();
  for (var s in seriesList) {
    if (s != null && s.isNotEmpty) {
      var moviesOfSeries =
      allMovies.where((element) => element.info?.serienName == s);
      if (moviesOfSeries.length > 1) {
        //Only map those, that contain more then 1 movie
        seriesMap[s] = moviesOfSeries.toList();
      }
    }
  }
  var allSeriesValues =
  seriesMap.values.reduce((value, element) => value += element);
  var moviesWithoutSeries = List.from(allMovies)
    ..removeWhere((element) => allSeriesValues.contains(element));
  assert(
  allMovies.length == allSeriesValues.length + moviesWithoutSeries.length);
}
