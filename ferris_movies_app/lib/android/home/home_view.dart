import '../drawer/my_drawer.dart';
import 'package:ferris_movies_app/android/settings/settings_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  static const String routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      restorationId: "homeView",
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: const [
          Spacer(),
          Text("Hello World!"),
          Spacer(),
        ],
      )
    );
  }
}
