import 'package:flutter/material.dart';
import '../navigation/my_drawer.dart';

class MyCollectionsOverviewPage extends StatefulWidget {
  const MyCollectionsOverviewPage({Key? key}) : super(key: key);

  @override
  State<MyCollectionsOverviewPage> createState() =>
      _MyCollectionsOverviewPageState();
}

class _MyCollectionsOverviewPageState extends State<MyCollectionsOverviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Collections"),
        ),
        drawer: const MyDrawer(),
        body: Center(
          child: Column(
            children: const [
              Text("List all collections here"),
              Placeholder(),
            ],
          ),
        ));
  }
}
