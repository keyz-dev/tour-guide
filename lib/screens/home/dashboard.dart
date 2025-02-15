import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_aid/components/display_attractions.dart';
import 'package:tour_aid/components/my_text.dart';
import 'package:tour_aid/screens/get_started.dart';

import '../../utils/colors.dart';
import '../../utils/userProvider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController _controller = TextEditingController();
  String? _searchQuery;

  void _performSearch() {
    setState(() {
      _searchQuery = _controller.text; // Store the search query
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  spacing: 30,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          spacing: 8,
                          children: [
                            CircleAvatar(
                              radius: 27, // Adjust size
                              backgroundImage:
                                  NetworkImage(user!.profileImage!),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              spacing: 6,
                              children: [
                                MyText(
                                  text: user.name ?? "Guest",
                                  color: AppColors.primaryBlackBold,
                                  size: 18,
                                ),
                                MyText(
                                  text: user.role ?? "user",
                                  color: AppColors.primaryBlue,
                                  size: 14,
                                )
                              ],
                            )
                          ],
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: AppColors.primaryWhite,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.primaryBlue, width: 1.2)),
                          child: IconButton(
                            color: AppColors.primaryBlue,
                            iconSize: 20,
                            icon: Icon(Icons.logout),
                            onPressed: () {
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
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10,
                      children: [
                        MyText(
                          text: "Explore the hidden Beauty of",
                          size: 22,
                          align: TextAlign.center,
                        ),
                        MyText(
                          text: "The Center!",
                          size: 42,
                          weight: FontWeight.w800,
                          align: TextAlign.center,
                        ),
                      ],
                    ),
                    //   The search input
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: _controller.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  _controller.clear(); // Clear the text field
                                  setState(() {
                                    _searchQuery =
                                        null; // Reset the search query
                                  });
                                },
                              )
                            : null,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: AppColors.indicatorInActive,
                      ),
                    ),
                  ],
                ),
              )),
          //  The intro to the tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    text: "Visit Places",
                    align: TextAlign.left,
                    weight: FontWeight.w600,
                    size: 20,
                  ),
                  MyText(
                    text: "ViewMore",
                    align: TextAlign.left,
                    size: 15,
                    color: AppColors.primaryGrey,
                  ),
                ]),
          ),
          Expanded(
              child:
                  AttractionSitesDisplay()), // Add the attraction sites display here
        ],
      ),
    ));
  }
}
