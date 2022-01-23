import 'package:flutter/cupertino.dart';


class MyIosApp extends StatelessWidget {
  const MyIosApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: "Ferris Movies App",
      /*
      routes: {
        '/': (context) => const MyTemplatePage(),
        //MyVideoPage.routeName : (context) => const MyVideoPage(),
        '/listOfAll': (context) => const MyListPage(),
        '/settings': (context) => const MySettingsPage(),
        '/myCollections': (context) => const MyCollectionsOverviewPage(),
      },
      initialRoute: '/',
      */
      home: Placeholder(),
    );
  }
}
