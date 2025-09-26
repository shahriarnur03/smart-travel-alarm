import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_travel_alarm/features/onboarding/models/onboarding_model.dart';
import 'package:smart_travel_alarm/features/location/pages/location_screen.dart';

class OnboardingController extends GetxController {
  // PageController for PageView
  final PageController pageController = PageController();
  
  // Observable variables using GetX
  final currentPage = 0.obs; // .obs makes it reactive/observable
  
  // Onboarding data
  final List<OnboardingModel> onboardingData = OnboardingModel.getOnboardingData();
  
  // Method to go to next page
  void nextPage() {
    if (currentPage.value < onboardingData.length - 1) {
      // Go to next page
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to location screen using GetX navigation
      Get.off(() => const LocationScreen()); // Get.off replaces current screen
    }
  }
  
  // Method to update current page (called when user swipes)
  void updatePage(int index) {
    currentPage.value = index;
  }
  
  // Clean up resources when controller is disposed
  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}