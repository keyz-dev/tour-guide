import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_aid/screens/home/main.dart';
import '../../utils/userProvider.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final String title = "Favorites";

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
