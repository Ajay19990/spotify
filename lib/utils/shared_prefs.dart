import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final SharedPrefs _instance = SharedPrefs._ctor();

  factory SharedPrefs() {
    return _instance;
  }

  SharedPrefs._ctor();

  static late SharedPreferences _prefs;

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static setString(String key, String value) {
    _prefs.setString(key, value);
  }

  static setInt(String key, int value) {
    _prefs.setInt(key, value);
  }

  static String getString(String key) {
    return _prefs.getString(key) ?? "";
  }

  static setListValue(String key, List<String> list) {
    _prefs.setStringList(key, list);
  }

  static List<String> getListValue(String key) {
    return _prefs.getStringList(key) ?? [];
  }

  static Map<String, dynamic> getAllPrefs() {
    final keys = _prefs.getKeys();
    final Map<String, dynamic> prefsMap = {};
    for (String key in keys) {
      prefsMap[key] = _prefs.get(key);
    }
    return prefsMap;
  }

  static removeValue(String key) {
    return _prefs.remove(key);
  }

  static clear() {
    return _prefs.clear();
  }
}
