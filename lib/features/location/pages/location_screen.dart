import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_travel_alarm/common_widgets/app_background.dart';
import 'package:smart_travel_alarm/common_widgets/common_button.dart';
import 'package:smart_travel_alarm/constants/app_text_styles.dart';
import 'package:smart_travel_alarm/features/home/pages/home_screen.dart';
import 'package:smart_travel_alarm/features/location/widgets/location_button.dart';
import 'package:smart_travel_alarm/helpers/location_service.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  bool _isLoadingLocation = false;
  String? _currentLocation;

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoadingLocation = true;
    });

    try {
      Map<String, dynamic>? locationData = await LocationService.getCurrentLocationWithAddress();
      
      if (locationData != null) {
        setState(() {
          _currentLocation = locationData['address'];
        });
        
        // Show success dialog
        String message = 'Your current location: ${locationData['address']}';
        if (locationData['address'].toString().contains('Lat:')) {
          message += '\n\n(Address lookup failed)';
        }
        
        _showLocationDialog(
          'Location Found',
          message,
          true,
        );
      } else {
        // Show error dialog
        _showLocationDialog(
          'Location Error',
          'Unable to get your location. Please check if location services are enabled and permissions are granted.',
          false,
        );
      }
    } catch (e) {
      // Simple error handling
      _showLocationDialog(
        'Location Error',
        'Unable to get location. Please check your GPS and location permissions.',
        false,
      );
    } finally {
      setState(() {
        _isLoadingLocation = false;
      });
    }
  }

  void _showLocationDialog(String title, String message, bool isSuccess) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            if (!isSuccess && (message.contains('permissions') || message.contains('Location services')))
              TextButton(
                child: const Text('Open Settings'),
                onPressed: () {
                  Navigator.of(context).pop();
                  // Open app settings
                  Geolocator.openAppSettings();
                },
              ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome! Your Smart Travel Alarm',
                      style: AppTextStyles.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Stay on schedule and enjoy every \nmoment of your journey.',
                      style: AppTextStyles.poppins(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Container(
                  width: 296,
                  height: 296,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              if (_currentLocation != null)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _currentLocation!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
              LocationButton(
                onPressed: _getCurrentLocation,
                isLoading: _isLoadingLocation,
              ),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: CommonButton(
                  text: "Home", 
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(selectedLocation: _currentLocation),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
