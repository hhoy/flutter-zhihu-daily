import 'package:shared_preferences/shared_preferences.dart';
export 'package:shared_preferences/shared_preferences.dart';
export 'package:flutter_zhihu_daily/resources/shared_preferences_keys.dart';

//SharedPreferences工具类的简单包装
class SpUtil{
  static SpUtil _instance;
  SharedPreferences _sharedPreferences;

  SpUtil._();

  static Future<SpUtil> getInstance() async {
    if (_instance == null) {
      var sharedPreferences  = await SharedPreferences.getInstance();
      _instance=SpUtil._().._sharedPreferences=sharedPreferences;
    }
    return _instance;
  }

  Future<bool> clear() {
    return _sharedPreferences.clear();
  }

  bool containsKey(String key) {
    return _sharedPreferences.containsKey(key);
  }

  get(String key) {
    return _sharedPreferences.get(key);
  }

  bool getBool(String key,{bool defaultValue:false}) {
    return _sharedPreferences.getBool(key)??defaultValue;
  }

  double getDouble(String key,{double defaultValue:0}) {
    return _sharedPreferences.getDouble(key)??defaultValue;
  }

  int getInt(String key,{int defaultValue:0}) {
    return _sharedPreferences.getInt(key)??defaultValue;
  }

  Set<String> getKeys() {
    return _sharedPreferences.getKeys();
  }

  String getString(String key) {
    return _sharedPreferences.getString(key);
  }

  List<String> getStringList(String key) {
    return _sharedPreferences.getStringList(key);
  }

  Future<void> reload() {
    return _sharedPreferences.reload();
  }

  Future<bool> remove(String key) {
    return _sharedPreferences.remove(key);
  }

  Future<bool> setBool(String key, bool value) {
    return _sharedPreferences.setBool(key, value);
  }

  Future<bool> setDouble(String key, double value) {
    return _sharedPreferences.setDouble(key, value);
  }

  Future<bool> setInt(String key, int value) {
    return _sharedPreferences.setInt(key, value);
  }

  Future<bool> setString(String key, String value) {
    return _sharedPreferences.setString(key, value);
  }

  Future<bool> setStringList(String key, List<String> value) {
    return _sharedPreferences.setStringList(key, value);
  }
}