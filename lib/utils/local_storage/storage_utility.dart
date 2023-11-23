import 'package:shared_preferences/shared_preferences.dart';

class TLocalStorage {
  static SharedPreferences? _prefs;

  /// Initialize the local storage.
  static Future<void> _init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Save String to the local storage.
  static Future<void> saveString(String key, String value) async {
    await _init();
    await _prefs!.setString(key, value);
  }

  /// Get String from the local storage.
  static Future<String?> getString(String key) async {
    await _init();
    return _prefs!.getString(key);
  }

  /// Save int to the local storage.
  static Future<void> saveInt(String key, int value) async {
    await _init();
    await _prefs!.setInt(key, value);
  }

  /// Get int from the local storage.
  static Future<int?> getInt(String key) async {
    await _init();
    return _prefs!.getInt(key);
  }

  /// Save bool to the local storage.
  static Future<void> saveBool(String key, bool value) async {
    await _init();
    await _prefs!.setBool(key, value);
  }

  /// Get bool from the local storage.
  static Future<bool?> getBool(String key) async {
    await _init();
    return _prefs!.getBool(key);
  }

  /// Remove key from the local storage.
  static Future<void> remove(String key) async {
    await _init();
    await _prefs!.remove(key);
  }
}

/// This class contains all the App Keys in String format.
class TLocalStorageKeys {
  TLocalStorageKeys._();

  static const String token = 'token';
  static const String userId = 'userId';
  static const String isFirstTime = 'isFirstTime';
}
