import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();
  factory LocalStorageService() => _instance;
  LocalStorageService._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveData(String key, dynamic value) async {
    // String jsonData = jsonEncode(value);
    await _prefs?.setString(key, value.toString());
  }

  String? getStr(String key) {
    return _prefs?.getString(key);
  }

  Future<T?> getData<T>(
      String key, T Function(Map<String, dynamic>) fromJson) async {
    String? jsonData = _prefs?.getString(key);
    if (jsonData == null) return null;
    return fromJson(jsonDecode(jsonData));
  }

  Future<void> saveUsername(String username) async {
    await _prefs?.setString('saved_username', username);
  }

  String? getUsername() {
    return _prefs?.getString('saved_username');
  }

  Future<void> clearUsername() async {
    await _prefs?.remove('saved_username');
  }

  Future<void> removeData(String key) async {
    await _prefs?.remove(key);
  }

  Future<void> clear() async {
    final savedUsername = getUsername();
    await _prefs?.clear();
    if (savedUsername != null) {
      await saveUsername(savedUsername);
    }
  }
}
