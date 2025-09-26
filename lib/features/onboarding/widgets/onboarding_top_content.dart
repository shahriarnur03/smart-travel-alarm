import 'package:flutter/material.dart';
import 'package:smart_travel_alarm/constants/app_text_styles.dart';
import 'package:smart_travel_alarm/features/onboarding/models/onboarding_model.dart';
import 'package:smart_travel_alarm/features/onboarding/widgets/video_widget.dart';

class OnboardingTopContent extends StatelessWidget {
  final OnboardingModel onboardingItem;

  const OnboardingTopContent({
    super.key,
    required this.onboardingItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: VideoWidget(videoPath: onboardingItem.videoPath),
        ),
        const SizedBox(height: 20),
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Text(
                  onboardingItem.title,
                  style: AppTextStyles.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  onboardingItem.description,
                  style: AppTextStyles.oxygen(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}