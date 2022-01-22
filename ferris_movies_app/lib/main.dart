import 'dart:collection';
import 'package:flutter/material.dart';

import 'models/movie.dart';

import 'pages/my_collections_overview_page.dart';
import 'pages/my_settings_page.dart';
import 'pages/my_list_page.dart';
import 'pages/my_video_page.dart';
import 'pages/my_template_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutterino',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      //home: const MyHomePage(title: 'Flutterino Home Page'),
      routes: {
        '/': (context) => const MyTemplatePage(),
        //MyVideoPage.routeName : (context) => const MyVideoPage(),
        '/listOfAll': (context) => const MyListPage(),
        '/settings': (context) => const MySettingsPage(),
        '/myCollections': (context) => const MyCollectionsOverviewPage(),
      },
      initialRoute: '/',
    );
  }
}

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
