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

  /// Convert alarm to JSON map for storage
  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'date': date,
      'isEnabled': isEnabled,
      'notificationId': notificationId,
      'scheduledDateTime': scheduledDateTime?.toIso8601String(),
    };
  }

  /// Create alarm from JSON map
  factory AlarmModel.fromJson(Map<String, dynamic> json) {
    return AlarmModel(
      time: json['time'] ?? '',
      date: json['date'] ?? '',
      isEnabled: json['isEnabled'] ?? false,
      notificationId: json['notificationId'] ?? 0,
      scheduledDateTime: json['scheduledDateTime'] != null 
          ? DateTime.parse(json['scheduledDateTime']) 
          : null,
    );
  }
}