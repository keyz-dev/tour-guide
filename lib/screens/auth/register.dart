import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tour_aid/components/elevated_button.dart';
import 'package:tour_aid/components/my_text.dart';
import 'package:tour_aid/utils/colors.dart';
import 'package:tour_aid/utils/userValidator.dart';
import '../../components/text_field.dart';
import '../../services/auth.dart';
import '../../services/cloudinary.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cPasswordController = TextEditingController();
  String? _password;
  File? _profileImage;
  XFile? _image;
  String gender = 'Male';
  DateTime? _selectedDate;
  bool _isLoading = false;

  // Method that handles the registration
  void register() async {
    setState(() {
      _isLoading = true;
    });

    if (_formKey.currentState!.validate()) {

      // Upload profile picture to cloudinary
      String? profilePicUrl;
      String? error;
      try{
        if (_profileImage != null) {
          var uploadResult = await CloudinaryService().uploadImage(_profileImage!, imagePath: "profile_images");
          if(uploadResult['success'] ==  false){
            throw Exception(uploadResult['value']);
          }
            profilePicUrl = uploadResult['value'];
        }
        error = await AuthService().registerUser(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          phone: _phoneController.text.trim(),
          city: _cityController.text.trim(),
          dob: _dobController.text.trim(),
          gender: gender,
          profileImage: profilePicUrl!,
        );

        setState(() {
          _isLoading = false;
        });

        if (error == null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registration Successful")));
          Navigator.pop(context);
        } else {
          throw Exception(error);
        }
      }catch (e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  // Function to show the date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Initial date shown in the picker
      firstDate: DateTime(1900),  // Earliest selectable date
      lastDate: DateTime.now(),   // Latest selectable date (today)
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);// Update the selected date
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String registerImage = "assets/images/auth/register.png";
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: Image.asset(
                  registerImage,
                  fit: BoxFit.cover,
                  scale: 1.5, // Optional: Further reduce the size
                ),
              ),
              Container(
                width: double.infinity,
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        MyTextField(
                          hintText: "Enter your Full names",
                          labelText: "Full Name",
                          icon: Icons.person,
                          controller: _nameController, fillColor: AppColors.indicatorInActive,
                          validator: (value)=> (value == null || value.isEmpty) ? 'Name cannot be empty' : null
                        ),
                        const SizedBox(height: 15),
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
                          hintText: "Enter your phone number",
                          labelText: "Phone Number (+237)",
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                          controller: _phoneController,
                          fillColor: AppColors.indicatorInActive,
                          validator: (value) => value!.length != 9 ? 'Phone number must be 9 digits' : null,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            // DropdownButtonFormField for Gender
                            Expanded( // Ensure the dropdown takes up available space
                              child: DropdownButtonFormField<String>(
                                value: gender, // Ensure this is initialized or nullable
                                onChanged: (val) {
                                  setState(() {
                                    gender = val!; // Update the selected value
                                  });
                                },
                                items: ["Male", "Female", "Other"]
                                    .map<DropdownMenuItem<String>>((g) => DropdownMenuItem(
                                  value: g,
                                  child: Text(g),
                                ))
                                    .toList(),
                                decoration: const InputDecoration(
                                  labelText: 'Gender',
                                  border: OutlineInputBorder(), // Optional: Add a border for better UI
                                ),
                              ),
                            ),
                            const SizedBox(width: 16), // Add spacing between the widgets

                            // TextFormField for DOB
                            Expanded( // Ensure the text field takes up available space
                              child: MyTextField(
                                labelText: "Date of Birth",
                                fillColor: AppColors.indicatorInActive,
                                controller: _dobController,
                                readOnly: true, // Make the field read-only
                                onTap: () => _selectDate(context), // Show date picker on ta
                                validator: validateDOB,
                                icon: Icons.calendar_month,// Your validation function
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),
                        MyTextField(
                          hintText: "Enter your resident city",
                          labelText: "Resident City",
                          icon: Icons.location_city,
                          controller: _cityController,
                          fillColor: AppColors.indicatorInActive,
                        ),
                        const SizedBox(height: 15),
                        MyTextField(
                          hintText: "Enter your password",
                          labelText: "Password",
                          icon: Icons.lock,
                          obscureText: true,
                          controller: _passwordController,
                          validator: (value) => value!.length < 5 ? 'password too short': null,
                          fillColor: AppColors.indicatorInActive,
                        ),
                        const SizedBox(height: 15),
                        MyTextField(
                          hintText: "confirm password",
                          labelText: "Confirm Password",
                          obscureText: true,
                          icon: Icons.lock,
                          controller: _cPasswordController,
                          fillColor: AppColors.indicatorInActive,
                          validator: (value) {
                            return (value != _passwordController.text) ? 'passwords do not match': null; },
                        ),
                        const SizedBox(height: 15,),
                        GestureDetector(
                          onTap: () async {
                            XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                            File? imagePath = image != null ? File(image.path) : null;
                            setState(() {
                              _image = image;
                              _profileImage = imagePath;
                            });
                          },
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                            child: _profileImage == null ? Icon(Icons.camera_alt, size: 50) : null,
                          ),
                        ),

                        const SizedBox(height: 20),
                        //   Submit button
                        _isLoading ?
                        MyElevatedButton(
                          onPressed: () {},
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
                          onPressed: register,
                          radius: 5.0,
                          width: double.infinity,
                          backgroundColor: AppColors.indicatorActive,
                          child: MyText(
                              text: 'Sign Up',
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
                            MyText(text: "Already have an account? ", size: 15),
                            InkWell(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Login()
                                      )
                                  );
                                },
                                child: MyText(text: "Login", weight: FontWeight.w700, size: 15)
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
