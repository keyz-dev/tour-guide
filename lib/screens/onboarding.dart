import 'package:flutter/material.dart';
import 'package:tour_aid/components/my_text.dart';
import 'package:tour_aid/components/onboarding_data.dart';
import 'package:tour_aid/components/text_button.dart';
import 'package:tour_aid/screens/get_started.dart';
import 'package:tour_aid/utils/colors.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = OnboardingData();
  final pageController = PageController();
  int _currentIndex = 0;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: AppColors.primaryWhite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [skip(), body(), dots(), button()],
          )),
    );
  }

// Skip Button
  Widget skip() {
    return Container(
      padding: const EdgeInsets.only(right: 20, top: 60),
      child: Align(
          alignment: Alignment.topRight,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
                onTap: () {
                  // Move to the getstard Page
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GetStarted()));
                },
                child: MyText(
                    text: "Skip",
                    size: 15,
                    color: _isHovered
                        ? AppColors.primaryGrey
                        : AppColors.primaryBlack)),
          )),
    );
  }

// Body
  Widget body() {
    return Expanded(
      child: PageView.builder(
          onPageChanged: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          itemCount: controller.items.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(controller.items[_currentIndex].image),
                      const SizedBox(
                        height: 10,
                      ),
                      MyText(
                          text: controller.items[_currentIndex].title,
                          size: 28,
                          weight: FontWeight.w700),
                      const SizedBox(
                        height: 20,
                      ),
                      MyText(
                        text: controller.items[_currentIndex].description,
                        size: 17,
                        height: 1.5,
                        color: AppColors.primaryGrey,
                        align: TextAlign.center,
                      )
                    ]));
          }),
    );
  }

// Dots
  Widget dots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(controller.items.length, (index) {
        return AnimatedContainer(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: _currentIndex == index
                    ? AppColors.indicatorActive
                    : AppColors.indicatorInActive),
            height: 7,
            width: _currentIndex == index ? 40 : 15,
            duration: const Duration(milliseconds: 300));
      }),
    );
  }

// button
  Widget button() {
    return MyTextButton(
        onPressed: () {
          setState(() {
            _currentIndex != controller.items.length - 1
                ? _currentIndex++
                : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const GetStarted()));
          });
        },
        backgroundColor: AppColors.primaryBlue,
        borderRadius: 0.0,
        width: MediaQuery.of(context).size.width * .9,
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: MyText(
          text: _currentIndex == controller.items.length - 1
              ? "Get Started"
              : "Continue",
          size: 17,
          weight: FontWeight.w700,
          color: AppColors.primaryWhite,
        ));
  }
}
