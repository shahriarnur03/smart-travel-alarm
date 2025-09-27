import 'package:flutter/material.dart';
import 'package:smart_travel_alarm/features/home/widgets/alarm_card.dart';
import 'package:smart_travel_alarm/features/home/models/alarm_model.dart';
import 'package:smart_travel_alarm/helpers/alarm_service.dart';
import 'package:smart_travel_alarm/helpers/alarm_storage_service.dart';

/// Widget that displays and manages a list of alarms
class AlarmList extends StatefulWidget {
  const AlarmList({super.key});

  @override
  State<AlarmList> createState() => AlarmListState();
}

class AlarmListState extends State<AlarmList> {
  final AlarmService _alarmService = AlarmService();
  
  /// List of all alarms - loaded from storage
  List<AlarmModel> _alarms = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAlarms();
  }

  /// Load alarms from storage
  Future<void> _loadAlarms() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final List<AlarmModel> loadedAlarms = await AlarmStorageService.loadAlarms();
      
      // If no alarms exist, create some sample data
      if (loadedAlarms.isEmpty) {
        final List<AlarmModel> sampleAlarms = [
          const AlarmModel(
            time: '7:10 pm',
            date: 'Fri 21 Mar 2025',
            isEnabled: true,
            notificationId: 1,
          ),
          const AlarmModel(
            time: '6:55 pm',
            date: 'Fri 21 Mar 2025',
            isEnabled: false,
            notificationId: 2,
          ),
          const AlarmModel(
            time: '7:10 pm',
            date: 'Fri 21 Mar 2025',
            isEnabled: true,
            notificationId: 3,
          ),
        ];
        
        // Save sample data
        await AlarmStorageService.saveAlarms(sampleAlarms);
        setState(() {
          _alarms = sampleAlarms;
        });
      } else {
        setState(() {
          _alarms = loadedAlarms;
        });
      }
    } catch (e) {
      _showError('Failed to load alarms');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Toggle alarm on/off
  Future<void> _toggleAlarm(int index) async {
    try {
      final currentAlarm = _alarms[index];
      final toggledAlarm = await _alarmService.toggleAlarm(currentAlarm);
      
      // Update in memory
      setState(() {
        _alarms[index] = toggledAlarm;
      });
      
      // Save to storage
      await AlarmStorageService.saveAlarms(_alarms);
    } catch (e) {
      _showError('Failed to toggle alarm');
    }
  }

  /// Add a new alarm
  Future<void> addAlarm(String time, String date, DateTime scheduledDateTime) async {
    try {
      final newAlarm = AlarmModel(
        time: time,
        date: date,
        isEnabled: true,
        notificationId: _alarmService.generateNotificationId(),
        scheduledDateTime: scheduledDateTime,
      );

      await _alarmService.scheduleAlarm(newAlarm);
      
      // Update in memory
      setState(() {
        _alarms.add(newAlarm);
      });
      
      // Save to storage
      await AlarmStorageService.saveAlarms(_alarms);
    } catch (e) {
      _showError('Failed to add alarm');
    }
  }

  /// Refresh alarms from storage
  Future<void> refreshAlarms() async {
    await _loadAlarms();
  }

  /// Show error message
  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Show loading indicator
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }

    // Handle empty state
    if (_alarms.isEmpty) {
      return const Center(
        child: Text(
          'No alarms set',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        ),
      );
    }

    return Column(
      children: _alarms.asMap().entries.map((entry) {
        final int index = entry.key;
        final AlarmModel alarm = entry.value;
        
        return AlarmCard(
          time: alarm.time,
          date: alarm.date,
          isEnabled: alarm.isEnabled,
          onToggle: () => _toggleAlarm(index),
        );
      }).toList(),
    );
  }
}