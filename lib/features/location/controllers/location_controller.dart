import 'package:get/get.dart';
import 'package:smart_travel_alarm/helpers/location_service.dart';

class LocationController extends GetxController {
  // Observable variables
  final currentLocation = Rxn<String>(); // Reactive nullable string
  final isLoading = false.obs; // Reactive boolean
  final hasError = false.obs; // Reactive boolean
  final errorMessage = ''.obs; // Reactive string

  // Get current location
  Future<void> getCurrentLocation() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      Map<String, dynamic>? locationData = await LocationService.getCurrentLocationWithAddress();
      
      if (locationData != null) {
        currentLocation.value = locationData['address'];
        _showSuccessMessage('Location updated successfully!');
      } else {
        _handleError('Unable to get location. Please check permissions.');
      }
    } catch (e) {
      _handleError('Location error: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  // Set location manually
  void setLocation(String location) {
    currentLocation.value = location.trim().isEmpty ? null : location.trim();
  }

  // Clear location
  void clearLocation() {
    currentLocation.value = null;
    _showSuccessMessage('Location cleared');
  }

  // Handle errors
  void _handleError(String message) {
    hasError.value = true;
    errorMessage.value = message;
    Get.snackbar(
      'Location Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.error,
      colorText: Get.theme.colorScheme.onError,
      duration: const Duration(seconds: 3),
    );
  }

  // Show success message
  void _showSuccessMessage(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.primaryColor,
      colorText: Get.theme.colorScheme.onPrimary,
      duration: const Duration(seconds: 2),
    );
  }

  // Initialize with existing location
  void initializeLocation(String? location) {
    if (location != null && location.isNotEmpty) {
      currentLocation.value = location;
    }
  }
}