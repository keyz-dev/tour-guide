import 'package:flutter/material.dart';
import 'package:tour_aid/components/elevated_button.dart';
import 'package:tour_aid/components/my_text.dart';
import 'package:tour_aid/screens/auth/register.dart';
import 'package:tour_aid/utils/colors.dart';

import '../../components/text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String loginImage = "assets/images/auth/login.png";
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Image.asset(loginImage),
                const SizedBox(height: 25),
                Container(
                    width: double.infinity,
                    child: Form(
                      key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            MyTextField(
                              hintText: "Enter your email",
                              labelText: "Email",
                              icon: Icons.email,
                              controller: _emailController,
                              fillColor: AppColors.indicatorInActive,
                              validator: (value) {
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
                                  return 'Enter a valid email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            MyTextField(
                              hintText: "Enter your password",
                              labelText: "Password",
                              icon: Icons.lock,
                              obscureText: true,
                              fillColor: AppColors.indicatorInActive,
                              controller: _passwordController,
                              validator: (value) => value!.length < 5 ? 'password too short': null,
                            ),
                            const SizedBox(height: 20),
                          //   Submit button
                            MyElevatedButton(
                              onPressed: (){},
                              radius: 5.0,
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
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyText(text: "Don't have an account? ", size: 15),
                                InkWell(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const Register()
                                        )
                                    );
                                  },
                                  child: MyText(text: "Signup Here", weight: FontWeight.w700, size: 15)
                                )
                              ],
                            )
                          ],
                        )
                    ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
