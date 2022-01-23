import 'package:ferris_movies_app/android/drawer/my_drawer.dart';
import 'package:ferris_movies_app/android/list_all/item_tile_view.dart';
import 'package:ferris_movies_app/helpers/asset_helper.dart';
import 'package:ferris_movies_app/models/movie.dart';
import 'package:flutter/material.dart';

class ListAllView extends StatefulWidget{
  const ListAllView({Key? key}) : super(key: key);

  static const routeName = "/browseall";

  @override
  State<ListAllView> createState() => _ListAllState();

}

class _ListAllState extends State<ListAllView>{
  @override
  Widget build(BuildContext stateContext) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List All Page"),
      ),
      drawer: const MyDrawer(),
      body: FutureBuilder<List<Movie>>(
        future: getMoviesFromAsset(),
        builder: (futureBuilderContext, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              restorationId: "allMoviesListView",
              itemCount: snapshot.data!.length,
              itemBuilder: (itemBuilderContext, index) {
                final movie = snapshot.data![index];
                return ItemTileView(movie: movie);
                //return ListTile(title: Text(movie.name),);
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

}
