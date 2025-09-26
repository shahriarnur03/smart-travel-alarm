import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_travel_alarm/common_widgets/app_background.dart';
import 'package:smart_travel_alarm/common_widgets/common_button.dart';
import 'package:smart_travel_alarm/features/onboarding/widgets/page_indicator.dart';
import 'package:smart_travel_alarm/features/onboarding/controllers/onboarding_controller.dart';
import 'package:smart_travel_alarm/features/onboarding/widgets/onboarding_top_content.dart';
import 'package:smart_travel_alarm/constants/app_text_styles.dart';

// Convert to StatelessWidget since GetX manages state
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put creates and injects the controller
    final OnboardingController controller = Get.put(OnboardingController());
    
    return Scaffold(
      body: AppBackground(
        child: Stack(
          children: [
            // Main content
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Top section - switchable content (video, title, description)
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: PageView.builder(
                        controller: controller.pageController,
                        onPageChanged: controller.updatePage, // Call controller method
                        itemCount: controller.onboardingData.length,
                        itemBuilder: (context, index) {
                          final onboardingItem = controller.onboardingData[index];
                          return OnboardingTopContent(onboardingItem: onboardingItem);
                        },
                      ),
                    ),
                    
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          // Obx rebuilds when currentPage changes
                          Obx(() => PageIndicator(
                            currentPage: controller.currentPage.value,
                            totalPages: controller.onboardingData.length,
                          )),
                          const SizedBox(height: 30),
                          CommonButton(
                            text: "Next",
                            onPressed: controller.nextPage, // Call controller method
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Skip button positioned at top-right
            Positioned(
              top: 70,
              right: 22,
              child: TextButton(
                onPressed: controller.skipOnboarding,
                child: Text(
                  'Skip',
                  style: AppTextStyles.oxygen(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
