import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/movie.dart';

Uint8List _convertStringToUint8List(String str) =>
    Uint8List.fromList(str.codeUnits);
String _convertUint8ListToString(Uint8List uint8list) =>
    String.fromCharCodes(uint8list);

Uint8List _addStupidZeros(Uint8List original) {
  var keyWithZeros = Uint8List(original.length * 2);
  for (int i = 0; i < keyWithZeros.length; i++) {
    if (i.isEven) {
      int originalIndex = i >> 1; //shift right to divide by 2
      keyWithZeros[i] = original[originalIndex];
    } //else not needed, because default is 0
  }
  return keyWithZeros;
}

const _keyString = "WatchingMovies12";
final _keyWithZeros = _addStupidZeros(_convertStringToUint8List(_keyString));

/*
Future<Uint8List> _readFile(String filepath) async {
  final file = File(filepath);
  return await file.readAsBytes();
}
 */

Uint8List _getIVFromBytes(Uint8List bytes) => bytes.sublist(0, 16);

Uint8List _getDataFromBytes(Uint8List bytes) => bytes.sublist(16);

Uint8List _decryptData(Uint8List key, Uint8List iv, Uint8List cipher) {
  var aesCbc = BlockCipher('AES/CBC')
    ..init(false, ParametersWithIV(KeyParameter(key), iv));
  final paddedPlainText = Uint8List(cipher.length); // allocate space
  var offset = 0;
  while (offset < cipher.length) {
    offset += aesCbc.processBlock(cipher, offset, paddedPlainText, offset);
  }
  assert(offset == cipher.length);

  //this removes strange 0x07 which appear behind the closing bracket
  final closingBracket = Uint8List.fromList("]".codeUnits)[0];
  final closingBracketIndex = paddedPlainText.lastIndexOf(closingBracket);
  final plainText = paddedPlainText.sublist(0, closingBracketIndex + 1);

  return plainText;
}
/*
Future<List<dynamic>> _getMoviesFromFile(String filepath) async {
  final key = _keyWithZeros;
  final fileBytes = await _readFile(filepath);
  final iv = _getIVFromBytes(fileBytes);
  final cipher = _getDataFromBytes(fileBytes);
  final plain = _decryptData(key, iv, cipher);
  final plainString = _convertUint8ListToString(plain);
  final json = jsonDecode(plainString);
  return json;
}
 */

Future<Uint8List> _loadAsset() async {
  final data = await rootBundle.load('assets/movies.json.encrypted');
  return data.buffer.asUint8List();
}

Future<List<Movie>> getMoviesFromAsset() async {
  final key = _keyWithZeros;
  final fileBytes = await _loadAsset();
  final iv = _getIVFromBytes(fileBytes);
  final cipher = _getDataFromBytes(fileBytes);
  final plain = _decryptData(key, iv, cipher);
  final plainString = _convertUint8ListToString(plain);
  final Iterable l = jsonDecode(plainString);
  List<Movie> movies = List<Movie>.from(l.map((e) => Movie.fromJson(e)));
  return movies;
}
