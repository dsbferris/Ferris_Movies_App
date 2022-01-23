import 'dart:collection';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/movie.dart';

import 'package:flutter/material.dart';

import 'android/android_app.dart';
import 'android/settings/settings_controller.dart';
import 'android/settings/settings_service.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  if(Platform.isAndroid) {
    runApp(MyAndroidApp(settingsController: settingsController));
  } else if (Platform.isIOS) {
    runApp(MyAndroidApp(settingsController: settingsController));
  }
}




/*
class MyAndroidApp extends StatelessWidget {
  const MyAndroidApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ferris Movies App',
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

 */

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
