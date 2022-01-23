import 'package:ferris_movies_app/android/movie/movie_detail_view.dart';
import 'package:ferris_movies_app/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:filesize/filesize.dart';

class ItemTileView extends StatelessWidget {
  const ItemTileView({Key? key, required this.movie}) : super(key: key);

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
            builder: (context) => MovieDetailView(movie: movie),
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
            builder: (context) => MovieDetailView(movie: movie),
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
