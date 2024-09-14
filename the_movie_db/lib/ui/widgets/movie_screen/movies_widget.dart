import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/config/config.dart';
import 'package:the_movie_db/types/types.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';
import 'package:the_movie_db/ui/theme/card_movie_style.dart';
import 'package:the_movie_db/ui/widgets/elements/errors_widget.dart';
import 'package:the_movie_db/ui/widgets/movie_screen/click_movie_widget.dart';
import 'package:the_movie_db/ui/widgets/movie_screen/movies_model.dart';

class MoviesWidget extends StatefulWidget {
  const MoviesWidget({super.key});

  @override
  State<MoviesWidget> createState() => _MoviesWidgetState();
}

class _MoviesWidgetState extends State<MoviesWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final MoviesViewModel model = context.read<MoviesViewModel>();
    model.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    final String? message = context.watch<MoviesViewModel>().errorMessage;
    return Stack(
      children: <Widget>[
        ErrorsWidget(message: message),
        const _MoviesListBuilder(),
        const _SearchWidget(),
      ],
    );
  }
}

class _SearchWidget extends StatelessWidget {
  const _SearchWidget();

  @override
  Widget build(BuildContext context) {
    final MoviesViewModel model = context.read<MoviesViewModel>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: AppMovieCardStyle.findFieldDecorationMovie,
        onChanged: model.searchMovies,
      ),
    );
  }
}

class _MoviesListBuilder extends StatelessWidget {
  const _MoviesListBuilder();

  @override
  Widget build(BuildContext context) {
    final MoviesViewModel model = context.watch<MoviesViewModel>();
    final int length = model.movies.length;
    return ListView.builder(
      padding: const EdgeInsets.only(top: 76),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: length,
      itemExtent: 163,
      itemBuilder: (BuildContext context, int index) {
        model.showMovieAtIndex(index);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Stack(
            children: <Widget>[
              Container(
                decoration: AppMovieCardStyle.cardDecoration,
                clipBehavior: Clip.hardEdge,
                child: _MoviesListRow(index: index),
              ),
              ClickMovieWidget(index: index),
            ],
          ),
        );
      },
    );
  }
}

class _MoviesListRow extends StatelessWidget {
  const _MoviesListRow({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final MovieListRowData movie =
        context.read<MoviesViewModel>().movies[index];
    final String? posterPath = movie.posterPath;
    final String? title = movie.title ?? movie.name;
    return Row(
      children: <Widget>[
        if (posterPath != null)
          Image.network(
            Config.imageUrl(posterPath),
            width: 95,
          ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10),
              if (title != null)
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.boldBasicTextStyle,
                ),
              const SizedBox(height: 5),
              Text(
                movie.releaseDate ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.movieDataTextStyle,
              ),
              const SizedBox(height: 20),
              Text(
                movie.overview ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
