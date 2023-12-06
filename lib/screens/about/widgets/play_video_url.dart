import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayVideoURL extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;

  const PlayVideoURL({
    required this.videoPlayerController,
    this.looping = false,
    super.key,
  });

  @override
  State<PlayVideoURL> createState() => _PlayVideoURLState();
}

class _PlayVideoURLState extends State<PlayVideoURL> {
  late ChewieController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      looping: widget.looping,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      height: size.height * 0.3,
      padding: const EdgeInsets.all(8.0),
      child: Chewie(
        controller: _controller,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // IMPORTANT to dispose of all the used resources
    widget.videoPlayerController.dispose();
    _controller.dispose();
  }
}
