import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Icon(FontAwesomeIcons.ethereum, size: 50),
                ),
                Text(
                  "Flutterino",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
            decoration: const BoxDecoration(
              color: Colors.teal,
            ),
          ),
          ListTile(
            leading:
                const Icon(FontAwesomeIcons.americanSignLanguageInterpreting),
            title: const Text("Template"),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.home),
            title: const Text("Home"),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.hands),
            title: const Text("List of All"),
            onTap: () {
              Navigator.pushNamed(context, '/listOfAll');
            },
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.columns),
            title: const Text("My Collections"),
            onTap: () {
              Navigator.pushNamed(context, '/myCollections');
            },
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.cogs),
            title: const Text("Settings"),
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
    );
  }
}
