import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_travel_alarm/common_widgets/app_background.dart';
import 'package:smart_travel_alarm/common_widgets/common_button.dart';
import 'package:smart_travel_alarm/constants/app_text_styles.dart';
import 'package:smart_travel_alarm/features/home/pages/home_screen.dart';
import 'package:smart_travel_alarm/features/location/controllers/location_controller.dart';
import 'package:smart_travel_alarm/features/location/widgets/location_button.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late final LocationController locationController;

  @override
  void initState() {
    super.initState();
    // Simple: Get or create the LocationController
    locationController = Get.put(LocationController());
  }

  Future<void> _getCurrentLocation() async {
    await locationController.getCurrentLocation();
    // No popup - location updates silently in the UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 26),
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
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Stay on schedule and enjoy every \nmoment of your journey.',
                      style: AppTextStyles.poppins(fontSize: 19),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.width * 0.9,
                  constraints: const BoxConstraints(
                    maxWidth: 315,
                    maxHeight: 315,
                    minWidth: 200,
                    minHeight: 200,
                  ),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Obx(() => locationController.currentLocation.value != null
                  ? Container(
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
                              locationController.currentLocation.value!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink()),
              const SizedBox(height: 16),
              Obx(() => LocationButton(
                onPressed: _getCurrentLocation,
                isLoading: locationController.isLoading.value,
              )),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: CommonButton(
                  text: "Home", 
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(selectedLocation: locationController.currentLocation.value),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20), // Extra padding for landscape
            ],
          ),
        ),
      ),
    ),
    );
  }
}
