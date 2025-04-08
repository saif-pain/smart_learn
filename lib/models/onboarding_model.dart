class OnboardingModel {
  final String image, title, description;

  OnboardingModel(
      {required this.image, required this.title, required this.description});
}

List<OnboardingModel> onboardingData = [
  OnboardingModel(
    image: 'assets/images/onboarding1.png',
    title: 'Unlock Learning With SmartLearn',
    description:
        'Your Gateway To Quality Study Materials And Structured Learning',
  ),
  OnboardingModel(
    image: 'assets/images/onboarding2.png',
    title: 'Access Study Materials Anytime, Anywhere',
    description: 'Find Previous Year Questions And Lecture Slides Effortlessly',
  ),
  OnboardingModel(
    image: 'assets/images/onboarding3.png',
    title: 'Master Your Exams With Smart Resources',
    description: 'Enhance Your Academic Journey With Well Structured Resources',
  ),
  OnboardingModel(
    image: 'assets/images/onboarding4.png',
    title: 'Exclusive Learning For DIU Students',
    description: 'A Platform Designed For Your Academic Success',
  ),
];
