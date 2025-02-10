import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_aid/screens/get_started.dart';

import '../../utils/userProvider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, ${user?.name ?? "User"}"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Provider.of<UserProvider>(context, listen: false).clearUser();
              // Navigate back to login (implement your sign-out logic here)
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => GetStarted()),
              );
            },
          )
        ],
      ),

      body: user == null
          ? Center(child: Text("No user data available"))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Email: ${user.email}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Role: ${user.role}", style: TextStyle(fontSize: 18)),
            // Display additional information as needed.
          ],
        ),
      ),
    );
  }
}
