import 'dart:io';
import 'package:flutter/cupertino.dart' as cup;
import 'package:flutter/material.dart' as mat;


import 'ios/ios_app.dart';

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
    mat.runApp(MyAndroidApp(settingsController: settingsController));
  } else if (Platform.isIOS) {
    cup.runApp(const MyIosApp());
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
