import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_travel_alarm/features/onboarding/pages/onboarding_screen.dart';
import 'package:smart_travel_alarm/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await NotificationService().initializeWithoutPermissions();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}