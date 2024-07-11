import 'package:flutter/material.dart';
import 'package:the_movie_db/constants/actors_datas.dart';
import 'package:the_movie_db/ui/theme/app_colors.dart';
import 'package:the_movie_db/ui/theme/app_text_style.dart';

class ActorDetailsWidget extends StatefulWidget {
  const ActorDetailsWidget({super.key, required this.actorId});
  final int actorId;

  @override
  State<ActorDetailsWidget> createState() => _ActorDetailsWidgetState();
}

class _ActorDetailsWidgetState extends State<ActorDetailsWidget> {
  late final Actor actor;

  @override
  void initState() {
    super.initState();
    actor = actorsData.firstWhere((Actor el) => el.id == widget.actorId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(actor.name),
      ),
      body: ColoredBox(
        color: AppColors.appScreenCastColor,
        child: ListView(
          children: <Widget>[
            Image(
              image: AssetImage(actor.image),
            ),
            const SizedBox(height: 20),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Text(actor.name, style: AppTextStyle.castTitleStyle),
            ),
            const SizedBox(height: 20),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              child: Text(
                actor.description,
                style: AppTextStyle.castFullDescriptionStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
