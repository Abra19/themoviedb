import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/config/config.dart';
import 'package:the_movie_db/types/types.dart';
import 'package:the_movie_db/ui/theme/app_colors.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';
import 'package:the_movie_db/ui/widgets/actor_details/actor_details_model.dart';

class ActorDetailsWidget extends StatefulWidget {
  const ActorDetailsWidget({super.key});

  @override
  State<ActorDetailsWidget> createState() => _ActorDetailsWidgetState();
}

class _ActorDetailsWidgetState extends State<ActorDetailsWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ActorDetailsViewModel model = context.read<ActorDetailsViewModel>();
    final Locale locale = Localizations.localeOf(context);
    model.setupLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    final ActorDetailsViewModel model = context.watch<ActorDetailsViewModel>();
    final bool isLoading = model.data.isLoading;
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    final ActorDatas actor =
        context.select((ActorDetailsViewModel model) => model.data);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(actor.name),
        ),
        body: ColoredBox(
          color: AppColors.appScreenCastColor,
          child: ListView(
            children: <Widget>[
              if (actor.profilePath != null)
                Image.network(
                  Config.imageUrl(actor.profilePath!),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              const SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        actor.birthday,
                        style: AppTextStyle.castBirthdayStyle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        actor.placeOfBirth,
                        style: AppTextStyle.castBirthdayStyle,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Text(
                  actor.biography,
                  style: AppTextStyle.castFullDescriptionStyle,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                child: actor.deathday != ''
                    ? Row(
                        children: <Widget>[
                          const Expanded(
                            child: Text(
                              'Died',
                              style: AppTextStyle.castBirthdayStyle,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              actor.deathday,
                              style: AppTextStyle.castBirthdayStyle,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
