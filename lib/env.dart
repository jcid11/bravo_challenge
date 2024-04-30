import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'main.dart';

Future<Map<String, String>> loadEnvFile(String path) async {
  await dotenv.load(fileName: path);
  return dotenv.env;
}
bool isDevelopment() {
  return env!['ENV'] == 'DEV';
}