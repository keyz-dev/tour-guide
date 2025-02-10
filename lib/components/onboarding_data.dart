import 'package:tour_aid/components/onboarding_info.dart';

class OnboardingData {
  List<OnboardingInfo> items = [
    OnboardingInfo(
        title: "Explore Like a Local",
        description:
          "Skip the tourist traps and uncover hidden gems. With our app, you'll get access to authentic experiences recommended by locals who know their cities best.",
          image: "assets/images/onboarding/1.png"),
    OnboardingInfo(
        title: "Offline Mode – Always Ready",
        description:
        "Don't worry about losing signal abroad. Download maps and guides ahead of time so you can explore confidently, even without internet connection.",
        image: "assets/images/onboarding/2.png"),
    OnboardingInfo(
        title: "Personalized Adventures Awaits",
        description:
        "From adventure seekers to culture enthusiasts, we tailor suggestions just for you. Answer a few questions, and let us craft an itinerary that matches your style.",
        image: "assets/images/onboarding/3.png")
  ];
}
