import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Basic types
  Future<void> setString(String key, String value) async =>
      await _prefs.setString(key, value);

  String? getString(String key) => _prefs.getString(key);

  Future<void> setBool(String key, bool value) async =>
      await _prefs.setBool(key, value);

  bool? getBool(String key) => _prefs.getBool(key);

  Future<void> setInt(String key, int value) async =>
      await _prefs.setInt(key, value);

  int? getInt(String key) => _prefs.getInt(key);

  // String list
  Future<void> setStringList(String key, List<String> value) async =>
      await _prefs.setStringList(key, value);

  List<String>? getStringList(String key) => _prefs.getStringList(key);

  // Object (as JSON string)
  Future<void> setObject<T>(
    String key,
    T object,
    String Function(T) toJson,
  ) async {
    final jsonString = toJson(object);
    await _prefs.setString(key, jsonString);
  }

  T? getObject<T>(String key, T Function(Map<String, dynamic>) fromJson) {
    final jsonString = _prefs.getString(key);
    if (jsonString == null) return null;
    return fromJson(jsonDecode(jsonString));
  }

  // List of objects
  Future<void> setObjectList<T>(
    String key,
    List<T> list,
    String Function(T) encode,
  ) async {
    final encodedList = list.map(encode).toList();
    await _prefs.setStringList(key, encodedList);
  }

  List<T> getObjectList<T>(String key, T Function(String) decode) {
    final stringList = _prefs.getStringList(key) ?? [];
    return stringList.map(decode).toList();
  }

  // Clear
  Future<void> remove(String key) async => await _prefs.remove(key);
  Future<void> clearAll() async => await _prefs.clear();
}
