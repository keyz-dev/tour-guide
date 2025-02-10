import 'package:flutter/material.dart';
import 'package:tour_aid/components/elevated_button.dart';
import 'package:tour_aid/components/my_text.dart';
import 'package:tour_aid/screens/auth/login.dart';
import 'package:tour_aid/screens/home/main.dart';
import 'package:tour_aid/utils/colors.dart';

import '../components/text_button.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  final String myTitle = "Let's Get Started";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: AppColors.primaryWhite,
            child: Column(children: [
              const SizedBox(
                height: 40,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/get_started.png'),
                        fit: BoxFit.cover)),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: double.infinity,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const MyText(
                            text: "Let's get started",
                            size: 28,
                            weight: FontWeight.w700),
                        const SizedBox(
                          height: 15,
                        ),
                        MyText(
                          text:
                          "Login or continue as guest to find out what attractive sites lie ahead to explore",
                          size: 17,
                          height: 1.5,
                          color: AppColors.primaryGrey,
                          align: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        MyElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()
                                )
                            );
                          },
                          radius: 4.0,
                          width: double.infinity,
                          backgroundColor: AppColors.indicatorActive,
                          child: MyText(
                              text: 'Login',
                              color: AppColors.primaryWhite,
                              weight: FontWeight.w600,
                              align: TextAlign.center,
                              size: 17
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyText(
                            text: 'or',
                            color: AppColors.primaryBlack,
                            weight: FontWeight.w600,
                            align: TextAlign.center,
                            size: 15
                        ),
                        MyTextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()
                                )
                            );
                          },
                          width: MediaQuery.of(context).size.width * .9,
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          borderRadius: 5.0,
                          borderSide:  BorderSide(color: AppColors.inputBorderColor, width: 1.0),
                          child: MyText(
                            text: "Continue as Guest",
                            size: 17,
                            weight: FontWeight.w700,
                            color: AppColors.primaryGrey
                          )
                        )
                      ]
                  )
              )
            ])
        )
    );
  }
}
