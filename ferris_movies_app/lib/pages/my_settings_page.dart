import 'package:flutter/material.dart';
import '../navigation/my_drawer.dart';

class MySettingsPage extends StatelessWidget {
  const MySettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter Page"),
      ),
      drawer: const MyDrawer(),
      body: const Placeholder(),
    );
  }
}
