import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_aid/components/my_text.dart';
import 'package:tour_aid/components/profile_menu.dart';
import 'package:tour_aid/components/text_button.dart';
import 'package:tour_aid/models/user.dart';
import 'package:tour_aid/screens/get_started.dart';
import 'package:tour_aid/screens/home/main.dart';
import 'package:tour_aid/utils/colors.dart';
import '../../utils/userProvider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final UserModel? user = Provider.of<UserProvider>(context).user;
    final String title = user?.name ?? "User Profile";

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
      ),
      body: user == null
          ? Center(child: Text("No user data available"))
          : SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 70, // Adjust size
                        backgroundImage: NetworkImage(user.profileImage!),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MyText(text: user.name, weight: FontWeight.bold),
                      const SizedBox(
                        height: 10,
                      ),
                      MyText(
                        text: user.email,
                        size: 16,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextButton(
                        onPressed: () {},
                        backgroundColor: AppColors.primaryBlue,
                        width: 170,
                        height: 48,
                        borderRadius: 5.0,
                        child: MyText(
                          text: "Edit Profile",
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: MyText(
                          text: "Personal Information",
                          size: 20,
                          weight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: Color.fromARGB(130, 226, 225, 225),
                      ),
                      ProfileMenuWidget(
                          title: "ID", icon: Icons.key, endText: user.id),
                      ProfileMenuWidget(
                          title: "Date of Birth",
                          icon: Icons.calendar_month,
                          endText: user.dob),
                      ProfileMenuWidget(
                          title: "Gender",
                          icon: Icons.heat_pump_sharp,
                          endText: user.gender),
                      ProfileMenuWidget(
                          title: "Phone Number",
                          icon: Icons.phone,
                          endText: user.phone),
                      ProfileMenuWidget(
                          title: "Address",
                          icon: Icons.location_city,
                          endText: user.city),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: MyText(
                          text: "Utilities",
                          size: 20,
                          weight: FontWeight.w600,
                        ),
                      ),
                      const Divider(
                        color: Color.fromARGB(130, 226, 225, 225),
                      ),
                      ProfileMenuWidget(
                          title: "Settings", icon: Icons.settings),
                      ProfileMenuWidget(
                        title: "Logout",
                        icon: Icons.logout,
                        textColor: const Color.fromARGB(255, 211, 79, 34),
                        onPress: () {
                          Provider.of<UserProvider>(context, listen: false)
                              .clearUser();
                          // Navigate back to login (implement your sign-out logic here)
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GetStarted()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
