import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:the_movie_db/ui/widgets/main_app/main_app_model.dart';
import 'package:the_movie_db/ui/widgets/main_app/main_app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final MainAppModel model = MainAppModel();

  await dotenv.load();
  await model.checkAuth();

  final MainApp app = MainApp(model: model);

  runApp(app);
}
