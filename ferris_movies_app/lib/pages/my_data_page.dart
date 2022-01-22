import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../helpers/asset_helper.dart' as assets;
import '../navigation/my_drawer.dart';

class MyDataPage extends StatelessWidget {
  const MyDataPage({Key? key}) : super(key: key);

  static Future<List<Movie>> futureMovies = assets.getMoviesFromAsset();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Page"),
      ),
      drawer: const MyDrawer(),
      body: const MyDataTable(),
    );
  }
}

class MyDataTable extends StatelessWidget {
  const MyDataTable({Key? key}) : super(key: key);

  static Future<List<Movie>> futureMovies = assets.getMoviesFromAsset();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: futureMovies,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Title',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Runtime',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Size',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ],
              rows: snapshot.data!
                  .map((movie) => DataRow(
                        cells: [
                          DataCell(Text(movie.name)),
                          DataCell(Text(filesize(movie.fileSize))),
                          DataCell(Text(filesize(movie.fileSize))),
                        ],
                      ))
                  .toList());
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
