import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:tour_aid/components/my_text.dart';
import 'package:tour_aid/screens/home/addAttraction.dart';
import 'package:tour_aid/screens/home/dashboard.dart';
import 'package:tour_aid/screens/home/explore.dart';
import 'package:tour_aid/screens/home/favorites.dart';
import 'package:tour_aid/screens/home/profile.dart';
import '../../utils/colors.dart';
import '../../utils/userProvider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // pages for the bottom nav

  int currentTab = 0;
  final List<Widget> screens = [
    Dashboard(),
    ExploreScreen(),
    AddAttractionScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    bool isAdmin = user!.role == 'admin';

    return Scaffold(
      body: PageStorage(bucket: bucket, child: currentScreen),
      bottomNavigationBar: currentTab == 2
          ? null
          : BottomAppBar(
              shape: CircularNotchedRectangle(),
              notchMargin: 10,
              child: Container(
                height: 45,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildNavBarItem(Icons.home, Dashboard(), 'Home', 0),
                      buildNavBarItem(
                          Icons.explore, ExploreScreen(), 'Explore', 1),
                      SizedBox(width: isAdmin ? 20 : 0),
                      buildNavBarItem(
                          Icons.favorite, FavoritesScreen(), 'Favorites', 3),
                      buildNavBarItem(
                          Icons.person, ProfileScreen(), 'Profile', 4),
                    ]),
              ),
            ),
      floatingActionButton: isAdmin && currentTab != 2
          ? ClipOval(
              child: Material(
                color: AppColors.primaryBlue,
                elevation: 10,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      currentScreen = AddAttractionScreen();
                      currentTab = 2;
                    });
                  },
                  child: SizedBox(
                    width: 56,
                    height: 56,
                    child: Icon(
                      Icons.add_circle_outline,
                      size: 28,
                      color: AppColors.primaryWhite,
                    ),
                  ),
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future<void> _launchMap() async {
    // Check for location permission
    var status = await Permission.location.status;

    if (status.isDenied) {
      // Request permission
      status = await Permission.location.request();
    }

    if (status.isGranted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ExploreScreen(),
        ),
      );
    } else {
      // Show an alert dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Location Permission Required'),
            content: Text('Please enable location permission to view the map'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Widget buildNavBarItem(
      IconData icon, Widget screen, String label, int index) {
    return MaterialButton(
      onPressed: () {
        // Check if they're launching the map page
        if (index == 1) {
          _launchMap();
        }
        setState(() {
          currentScreen = screen;
          currentTab = index;
        });
      },
      minWidth: 40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              color: currentTab == index
                  ? AppColors.primaryBlue
                  : AppColors.primaryGrey),
          MyText(
            text: label,
            color: currentTab == index
                ? AppColors.primaryBlue
                : AppColors.primaryGrey,
            size: 15,
          )
        ],
      ),
    );
  }
}
