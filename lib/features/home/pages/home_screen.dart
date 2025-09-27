import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:smart_travel_alarm/common_widgets/app_background.dart';
import 'package:smart_travel_alarm/constants/app_text_styles.dart';
import 'package:smart_travel_alarm/features/home/widgets/alarm_list.dart';
import 'package:smart_travel_alarm/features/location/controllers/location_controller.dart';
import 'package:smart_travel_alarm/helpers/alarm_service.dart';

class HomeScreen extends StatefulWidget {
  final String? selectedLocation;
  
  const HomeScreen({super.key, this.selectedLocation});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<AlarmListState> _alarmListKey = GlobalKey<AlarmListState>();
  final AlarmService _alarmService = AlarmService();
  final TextEditingController _locationController = TextEditingController();
  late final LocationController locationController;

  @override
  void initState() {
    super.initState();
    // Simple: Get or create the LocationController
    locationController = Get.put(LocationController());
    _requestNotificationPermissions();
    _initializeLocation();
  }

  void _initializeLocation() {
    locationController.initializeLocation(widget.selectedLocation);
    if (widget.selectedLocation != null) {
      _locationController.text = widget.selectedLocation!;
    }
    
    // Listen to location controller changes and update text field
    ever(locationController.currentLocation, (String? location) {
      if (location != null && mounted) {
        _locationController.text = location;
      }
    });
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  // Request notification permissions with proper error handling
  Future<void> _requestNotificationPermissions() async {
    try {
      final bool granted = await _alarmService.requestNotificationPermissions();
      if (!granted && mounted) {
        _showPermissionDialog();
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Failed to request notification permissions: ${e.toString()}');
      }
    }
  }

  // Show permission dialog when permissions are denied
  void _showPermissionDialog() {
    if (!mounted) return;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF201A42),
          title: const Text(
            'Notification Permission',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'This app needs notification permissions to ring alarms. Please enable notifications in your device settings.',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Open Settings',
                style: TextStyle(color: Color(0xFF5200FF)),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white70),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Show error message to user
  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }



  // Show date and time picker for adding new alarms
  Future<void> _showDateTimePicker() async {
    try {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2030),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.dark(
                primary: Color(0xFF5200FF),
                onSurface: Colors.white,
                surface: Color(0xFF201A42),
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedDate != null && mounted) {
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: Color(0xFF5200FF),
                  onSurface: Colors.white,
                  surface: Color(0xFF201A42),
                ),
              ),
              child: child!,
            );
          },
        );

        if (pickedTime != null && mounted) {
          final DateTime selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          
          await _addAlarm(selectedDateTime);
        }
      }
    } catch (e) {
      _showErrorSnackBar('Failed to open date/time picker: ${e.toString()}');
    }
  }

  // Add a new alarm
  Future<void> _addAlarm(DateTime dateTime) async {
    try {
      // Check if the selected time is in the future
      if (dateTime.isBefore(DateTime.now())) {
        _showErrorSnackBar('Cannot set alarm for past time');
        return;
      }

      final String formattedTime = DateFormat('h:mm a').format(dateTime);
      final String formattedDate = DateFormat('EEE dd MMM yyyy').format(dateTime);
      
      await _alarmListKey.currentState?.addAlarm(formattedTime, formattedDate, dateTime);
      
    } catch (e) {
      _showErrorSnackBar('Failed to add alarm: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppBackground(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    
                    // Selected Location Section
                    Obx(() => Text(
                      locationController.currentLocation.value ?? 'Selected Location',
                      style: AppTextStyles.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    )),

                    const SizedBox(height: 16),

                    // Location TextField
                    SizedBox(
                      height: 56,
                      child: TextField(
                        controller: _locationController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF201A42),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 16,
                          ),
                          prefixIcon: Obx(() => Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: locationController.isLoading.value ? null : locationController.getCurrentLocation,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: locationController.isLoading.value
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        ),
                                      )
                                    : Image.asset(
                                        'assets/images/location_icon.png',
                                        width: 20,
                                        height: 20,
                                        color: Colors.white,
                                      ),
                              ),
                            ),
                          )),
                          hintText: 'Add your location',
                          hintStyle: const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.27),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                        onChanged: (value) {
                          locationController.setLocation(value);
                        },
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Alarms Section
                    Text(
                      'Alarms',
                      style: AppTextStyles.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 16),

                    AlarmList(key: _alarmListKey),

                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          ),
      
          Positioned(
            bottom: 108,
            right: 16,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF5200FF),
                shape: BoxShape.circle,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _showDateTimePicker,
                  borderRadius: BorderRadius.circular(33),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
