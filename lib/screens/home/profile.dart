import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_aid/screens/get_started.dart';
import 'package:tour_aid/screens/home/main.dart';

import '../../utils/userProvider.dart';
import 'dashboard.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final String title = "User Profile";

    return Scaffold(
      appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          leading: BackButton(
            onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),

      ),

      body: user == null
          ? Center(child: Text("No user data available"))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18)),
            SizedBox(height: 10)
            // Display additional information as needed.
          ],
        ),
      ),
    );
  }
}
