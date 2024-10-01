import 'package:flutter/material.dart';
import 'package:the_movie_db/ui/theme/app_colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieTrailer extends StatefulWidget {
  const MovieTrailer({super.key, required this.trailerKey});

  final String trailerKey;

  @override
  State<MovieTrailer> createState() => _MovieTrailerState();
}

class _MovieTrailerState extends State<MovieTrailer> {
  late final YoutubePlayerController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.trailerKey,
      flags: const YoutubePlayerFlags(
        hideThumbnail: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final YoutubePlayer player = YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: AppColors.appButtonsColor,
      progressColors: const ProgressBarColors(
        playedColor: AppColors.appButtonsColor,
        handleColor: AppColors.appInputBorderColor,
      ),
      onEnded: (_) => Navigator.of(context).pop(),
    );

    return YoutubePlayerBuilder(
      player: player,
      builder: (BuildContext context, Widget player) {
        return Scaffold(
          appBar: AppBar(title: const Text('Play Trailer')),
          body: ColoredBox(
            color: AppColors.appBackgroundColor,
            child: Center(
              child: player,
            ),
          ),
        );
      },
    );
  }
}
