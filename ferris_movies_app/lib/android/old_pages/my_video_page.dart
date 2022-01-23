import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import '../../models/movie.dart';
import '../drawer/my_drawer.dart';

class MyVideoPage extends StatefulWidget {
  const MyVideoPage({Key? key, required this.movie}) : super(key: key);

  static const String routeName = "/video";

  final Movie movie;

  @override
  State<MyVideoPage> createState() => _MyVideoPageState();
}

class _MyVideoPageState extends State<MyVideoPage> {
  late VlcPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VlcPlayerController.network(
      widget.movie.getVideoFilePath(),
      options: VlcPlayerOptions(),
      hwAcc: HwAcc.AUTO,
      autoInitialize: true,
      autoPlay: true,
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await _videoPlayerController.stopRendererScanning();
    await _videoPlayerController.dispose();
    debugPrint("Disposed VLC");
  }

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Movie;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Page"),
      ),
      drawer: const MyDrawer(),
      body: Center(
        child: VlcPlayer(
          controller: _videoPlayerController,
          aspectRatio: 16 / 9,
          placeholder: const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
