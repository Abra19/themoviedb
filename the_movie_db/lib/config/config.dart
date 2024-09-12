import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static final String host = dotenv.env['HOST']!;

  static final String _imageUrl = dotenv.env['IMAGEURL']!;
  static String imageUrl(String path) => '$_imageUrl$path';

  static final String? apiKey = dotenv.env['API_KEY'];
  static final String? accountId = dotenv.env['ACCOUNT_ID'];
}
