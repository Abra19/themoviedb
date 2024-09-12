import 'package:flutter/material.dart';
import 'package:the_movie_db/config/config.dart';
import 'package:the_movie_db/domain/entities/actors/actor_details.dart';
import 'package:the_movie_db/library/providers/notify_provider.dart';
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
    NotifyProvider.read<ActorDetailsViewModel>(context)?.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    final ActorDetailsViewModel? model =
        NotifyProvider.watch<ActorDetailsViewModel>(context);
    final ActorDetails? actor = model?.actorDetails;
    if (actor == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(actor.name ?? 'Loading...'),
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
                )
              else
                const SizedBox.shrink(),
              const SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        actor.birthday != null
                            ? model!.stringFromDate(actor.birthday)
                            : '',
                        style: AppTextStyle.castBirthdayStyle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        actor.placeOfBirth ?? '',
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
                  actor.biography ?? '',
                  style: AppTextStyle.castFullDescriptionStyle,
                ),
              ),
              if (actor.biography == null)
                const SizedBox.shrink()
              else
                const SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                child: actor.deathday != null
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
                              model!.stringFromDate(actor.deathday),
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
