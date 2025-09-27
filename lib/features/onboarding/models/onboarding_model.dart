class OnboardingModel {
  final String videoPath;
  final String title;
  final String description;

  const OnboardingModel({
    required this.videoPath,
    required this.title,
    required this.description,
  });

  static List<OnboardingModel> getOnboardingData() {
    return [
      const OnboardingModel(
        title: 'Discover the world, one journey at a time.',
        description:
            'From hidden gems to iconic destinations, we make travel simple, inspiring, and unforgettable. Start your next adventure today.',
        
        videoPath: 'assets/videos/Trip_Moment.mp4',
      ),
      const OnboardingModel(
        title: 'Explore new horizons, one step at a time.',
        description:
            'Every trip holds a story waiting to be lived. Let us guide you to experiences that inspire, connect, and last a lifetime.',
        videoPath: 'assets/videos/Travel_Vintage.mp4',
      ),
      const OnboardingModel(
        title: 'See the beauty, one journey at a time.',
        description:
            'Travel made simple and exciting—discover places you\'ll love and moments you\'ll never forget.',
        videoPath: 'assets/videos/Blue_Tropical.mp4',
      ),
    ];
  }
}
