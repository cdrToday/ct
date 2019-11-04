import 'package:shared_preferences/shared_preferences.dart';

Future<String> getString(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String value = prefs.getString(key) ?? '';
  return value;
}

void setString(String key, dynamic value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

void clear() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
