import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import '../../models/movie.dart';
import '../drawer/my_drawer.dart';
import 'my_movie_detail_page.dart';
import '../../helpers/asset_helper.dart' as assets;

class MyListPage extends StatelessWidget {
  const MyListPage({Key? key}) : super(key: key);

  static const routeName = "/list";

  static Future<List<Movie>> futureMovies = assets.getMoviesFromAsset();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Page"),
      ),
      drawer: const MyDrawer(),
      body: FutureBuilder<List<Movie>>(
        future: futureMovies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var movie = snapshot.data![index];
                return MyListTileItem(movie: movie);
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

class MyListTileItem extends StatelessWidget {
  const MyListTileItem({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  ListTile _getListTileWithAMI(BuildContext context, String title, String size,
      String runtime, String genre) {
    return ListTile(
      title: Text(title),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(size),
          if (runtime.isNotEmpty) ...{
            Text(runtime),
          },
          if (genre.isNotEmpty) ...{
            Flexible(
              child: Text(
                genre,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          },
        ],
      ),
      isThreeLine: true,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyMovieDetailPage(movie: movie),
          ),
        );
      },
    );
  }

  ListTile _getListTileWithoutAMI(Movie movie, BuildContext context) {
    return ListTile(
      title: Text(movie.name),
      subtitle: Text(filesize(movie.fileSize)),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyMovieDetailPage(movie: movie),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var info = movie.info;
    if (info == null) {
      return _getListTileWithoutAMI(movie, context);
    } else {
      String runtime = "";
      var seconds = info.lengthSeconds ?? 0;
      var minutes = info.lengthMinutes ?? 0;
      if (seconds != 0) {
        runtime = _printDuration(Duration(seconds: seconds));
      } else if (minutes != 0) {
        runtime = _printDuration(Duration(seconds: minutes));
      }

      var genre = info.genre ?? "";
      var title = info.title ?? movie.name;
      var size = filesize(movie.fileSize).padLeft(10);
      return _getListTileWithAMI(context, title, size, runtime, genre);
    }
  }
}
