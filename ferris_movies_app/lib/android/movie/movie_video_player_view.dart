import 'package:ferris_movies_app/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class VideoPlayerView extends StatefulWidget{
  const VideoPlayerView({Key? key, required this.movie}) : super(key: key);

  static const String routeName = "/videoplayer";

  final Movie movie;

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();

}

class _VideoPlayerViewState extends State<VideoPlayerView>{
  late VlcPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VlcPlayerController.network(
      widget.movie.getVideoFilePath(),
      options: VlcPlayerOptions(),
      //autoInitialize: true,
      //autoPlay: true,
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
      //drawer: const MyDrawer(),
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
