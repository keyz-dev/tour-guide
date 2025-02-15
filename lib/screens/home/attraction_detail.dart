import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tour_aid/components/my_text.dart';
import 'package:tour_aid/models/attraction.dart';
import 'package:tour_aid/screens/home/explore.dart';
import 'package:tour_aid/screens/home/image_screen.dart';
import 'package:tour_aid/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AttractionDetail extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final AttractionSite site;

  const AttractionDetail({super.key, required this.site});

  // Function to launch the URL

  @override
  Widget build(BuildContext context) {
    // Opens a URL in the external browser

    Future<void> _launchURL(String urlString) async {
      try {
        final Uri url = Uri.parse(urlString);
        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
          throw 'Could not launch $urlString';
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
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
            builder: (context) => ExploreScreen(site: site),
          ),
        );
      } else {
        // Show an alert dialog
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Location Permission Required'),
              content:
                  Text('Please enable location permission to view the map'),
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

    // Launches the phone dialer with a prefilled number
    Future<void> _makePhoneCall(String phoneNumber) async {
      try {
        final Uri phoneUri = Uri(
          scheme: 'tel',
          path: phoneNumber,
        );
        if (!await launchUrl(phoneUri)) {
          throw 'Could not launch $phoneUri';
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }

    final additionalImages = site.additionalImages;

    return Scaffold(
      body: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height / 3,
          child: Stack(
            children: [
              Image.network(
                site.primaryImage,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              // Back button
              Positioned(
                top: 40,
                left: 16,
                child: IconButton(
                  color: AppColors.primaryBlue,
                  icon: Container(
                    padding: const EdgeInsets.all(
                        8.0), // Add padding around the icon
                    decoration: BoxDecoration(
                      color: Colors.blue, // Set the background color
                      shape: BoxShape
                          .circle, // Use a circular shape for the background
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white, // Set the icon color
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Positioned(
            top: MediaQuery.of(context).size.height / 2,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  Column(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      MyText(
                        text: site.name,
                        size: 28,
                        weight: FontWeight.w700,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 8,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 18,
                                  color: Colors.redAccent[400],
                                ),
                                MyText(
                                  text: site.town,
                                  size: 18,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 8,
                              children: [
                                Icon(Icons.star,
                                    color: Colors.yellow, size: 14),
                                MyText(
                                    text: site.rating.toString(),
                                    color: AppColors.primaryGrey,
                                    size: 14,
                                    weight: FontWeight.bold),
                              ],
                            )
                          ]),
                    ],
                  ),

                  // Description

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      MyText(
                        text: "Description",
                        size: 18,
                        weight: FontWeight.w700,
                      ),
                      MyText(
                        text: site.description,
                        size: 16,
                        height: 1.8,
                        color: const Color.fromARGB(255, 127, 125, 125),
                      )
                    ],
                  ),

                  // Website URL
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 8,
                    children: [
                      MyText(
                        text: "Website:",
                        size: 18,
                        weight: FontWeight.w700,
                      ),
                      site.websiteUrl == ''
                          ? MyText(
                              text: 'not available',
                              size: 18,
                            )
                          : GestureDetector(
                              onTap: () => _launchURL(site.websiteUrl!),
                              child: MyText(
                                text: site.websiteUrl!,
                                size: 18,
                                color: AppColors.indicatorActive,
                              )),
                    ],
                  ),
                  // Phone number

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 8,
                    children: [
                      MyText(
                        text: "Phone:",
                        size: 18,
                        weight: FontWeight.w700,
                      ),
                      site.phoneNumber == ''
                          ? MyText(
                              text: 'not available',
                              size: 18,
                            )
                          : GestureDetector(
                              onTap: () => _makePhoneCall(site.phoneNumber!),
                              child: MyText(
                                text: site.phoneNumber!,
                                size: 18,
                                color: AppColors.indicatorActive,
                              )),
                    ],
                  ),

                  // Additional images
                  Text(
                    "Better View",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  // Horizontal scrollable list of additional images
                  SizedBox(
                    height: 150, // Set a fixed height for the horizontal list
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: additionalImages.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              // Navigate to the full-screen image when tapped
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullImageScreen(
                                      imageUrl: additionalImages[index]),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                width: 150,
                                padding: const EdgeInsets.all(
                                    4.0), // Padding inside the container
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Optional: Rounded corners
                                  color: Colors.grey[
                                      200], // Background color for the container
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Match with the container
                                  child: Image.network(
                                    additionalImages[index],
                                    width: double.infinity,
                                    height:
                                        double.infinity, // Fill the container
                                    fit: BoxFit
                                        .cover, // Ensure the image covers the area
                                  ),
                                ),
                              ),
                            ));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 24, // Adjust for margin at the bottom
          left: 16, // Left margin
          right: 16, // Right margin
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(8), // Full width
            child: TextButton(
              onPressed: _launchMap,
              style: TextButton.styleFrom(
                backgroundColor: AppColors.indicatorActive,
                textStyle: TextStyle(fontSize: 18), // Text style
              ),
              child: Center(
                child: MyText(
                  text: "Locate Now",
                  color: AppColors.primaryWhite,
                  weight: FontWeight.w600,
                  size: 20,
                ), // Button text
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
