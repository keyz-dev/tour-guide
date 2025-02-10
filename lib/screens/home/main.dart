import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  final String myTitle = "Tour Aid";
  final String welcome = "Welcome to Tour Aid";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 32, 154, 255),
          title: Text(myTitle,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              )),
          centerTitle: true,
        ),
        body: Center(child: Text(welcome)));
  }
}
