import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_aid/screens/get_started.dart';
import 'package:tour_aid/screens/home/main.dart';

import '../../utils/userProvider.dart';
import 'dashboard.dart';

class AddAttractionScreen extends StatefulWidget {
  const AddAttractionScreen({super.key});

  @override
  State<AddAttractionScreen> createState() => _AddAttractionScreenState();
}

class _AddAttractionScreenState extends State<AddAttractionScreen> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final String title = "Attractions";

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
