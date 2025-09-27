import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_travel_alarm/features/home/models/alarm_model.dart';


class AlarmStorageService {
  static const String _key = 'alarms';

  /// Save alarms to phone storage
  static Future<void> saveAlarms(List<AlarmModel> alarms) async {
    final prefs = await SharedPreferences.getInstance();
    final alarmsJson = alarms.map((alarm) => alarm.toJson()).toList();
    await prefs.setString(_key, json.encode(alarmsJson));
  }

  /// Load alarms from phone storage
  static Future<List<AlarmModel>> loadAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_key);
    
    if (data == null) return [];
    
    final List<dynamic> decoded = json.decode(data);
    return decoded.map((json) => AlarmModel.fromJson(json)).toList();
  }
}