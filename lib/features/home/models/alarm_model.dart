class AlarmModel {
  final String time;
  final String date;
  final bool isEnabled;
  final int notificationId;
  final DateTime? scheduledDateTime;

  const AlarmModel({
    required this.time,
    required this.date,
    required this.isEnabled,
    required this.notificationId,
    this.scheduledDateTime,
  });

  /// Creates a copy of this alarm with the given fields replaced
  AlarmModel copyWith({
    String? time,
    String? date,
    bool? isEnabled,
    int? notificationId,
    DateTime? scheduledDateTime,
  }) {
    return AlarmModel(
      time: time ?? this.time,
      date: date ?? this.date,
      isEnabled: isEnabled ?? this.isEnabled,
      notificationId: notificationId ?? this.notificationId,
      scheduledDateTime: scheduledDateTime ?? this.scheduledDateTime,
    );
  }
}