import 'package:ferris_movies_app/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:filesize/filesize.dart';

class MovieDetailView extends StatelessWidget{
  const MovieDetailView({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(movie.name),
            Text(filesize(movie.fileSize)),
            movie.info == null
                ? const Text("No additional movie infos available")
                : const Text("Not null!"),
            ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (bContext) =>
                              MovieDetailView(movie: movie))),
                },
                child: const Text("Watch via VPN")),
          ],
        ),
      ),
    );
  }

}
