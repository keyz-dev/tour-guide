import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_aid/components/elevated_button.dart';
import 'package:tour_aid/components/my_text.dart';
import 'package:tour_aid/screens/auth/register.dart';
import 'package:tour_aid/screens/home/main.dart';
import 'package:tour_aid/services/auth.dart';
import 'package:tour_aid/utils/colors.dart';

import '../../components/text_field.dart';
import '../../models/user.dart';
import '../../utils/userProvider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void login() async{
    // Activate the progress indicator
    setState(() {
      _isLoading = true;
    });
  //   sign in the user
    try{
      User? firebaseUser = await AuthService().signInWithEmailPassword(_emailController.text, _passwordController.text);
      if(firebaseUser == null){
        throw Exception("Incorrect email or password");
      }
    //   Retrieve the user information
      UserModel? myUser = await AuthService().fetchUserModel(firebaseUser.uid);
      if (myUser == null){
        throw Exception("Incorrect email or password");
      }
      // Update the provider with user data.
      Provider.of<UserProvider>(context, listen: false).setUser(myUser);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );

    //   Stop the loader
      setState(() {
        _isLoading = false;
      });
    }catch (e){
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

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
                Container(
                    width: double.infinity,
                    child: Form(
                      key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Padding(
                              padding: EdgeInsets.only(bottom: 30),
                              child: Column(
                                spacing: 15,
                                children: [
                                  MyText(
                                    text: "Welcome Back",
                                    weight: FontWeight.w700,
                                    align: TextAlign.center,
                                    size: 30,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    child: MyText(
                                      text: "Resume your exploitation of amazing sites and attractions found in the center region of Cameroon",
                                      align: TextAlign.center,
                                      size: 14,
                                      height: 1.8,
                                      color: AppColors.primaryGrey,
                                    ),
                                  )
                                ],
                              )
                            ),
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

                            _isLoading ?
                            MyElevatedButton(
                              onPressed: (){},
                              radius: 5.0,
                              width: double.infinity,
                              backgroundColor: AppColors.indicatorActive,
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryWhite,
                                  strokeWidth: 3,
                                ),
                              )
                            )
                                :
                            MyElevatedButton(
                              onPressed: login,
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
                            ) ,
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
