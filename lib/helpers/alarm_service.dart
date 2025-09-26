import 'package:smart_travel_alarm/features/home/models/alarm_model.dart';
import 'package:smart_travel_alarm/helpers/notification_service.dart';

class AlarmService {
  final NotificationService _notificationService = NotificationService();

  Future<void> scheduleAlarm(AlarmModel alarm) async {
    try {
      if (alarm.scheduledDateTime == null) {
        throw Exception('Scheduled date time is required');
      }

      await _notificationService.scheduleAlarmNotification(
        id: alarm.notificationId,
        title: 'Travel Alarm 🚨',
        body: 'Your alarm for ${alarm.time} is ringing! Wake up!',
        scheduledTime: alarm.scheduledDateTime!,
      );
    } catch (e) {
      throw Exception('Failed to schedule alarm: $e');
    }
  }

  Future<void> cancelAlarm(int notificationId) async {
    try {
      await _notificationService.cancelNotification(notificationId);
    } catch (e) {
      throw Exception('Failed to cancel alarm: $e');
    }
  }

  Future<AlarmModel> toggleAlarm(AlarmModel alarm) async {
    try {
      final toggledAlarm = alarm.copyWith(isEnabled: !alarm.isEnabled);

      if (toggledAlarm.isEnabled && toggledAlarm.scheduledDateTime != null) {
        await scheduleAlarm(toggledAlarm);
      } else {
        await cancelAlarm(toggledAlarm.notificationId);
      }

      return toggledAlarm;
    } catch (e) {
      throw Exception('Failed to toggle alarm: $e');
    }
  }

  int generateNotificationId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }

  //Request notification permissions
  Future<bool> requestNotificationPermissions() async {
    try {
      return await _notificationService.requestPermissions();
    } catch (e) {
      throw Exception('Failed to request permissions: $e');
    }
  }
}