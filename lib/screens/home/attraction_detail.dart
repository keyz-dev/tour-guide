import 'package:flutter/material.dart';
import 'package:tour_aid/components/elevated_button.dart';
import 'package:tour_aid/components/my_text.dart';
import 'package:tour_aid/models/attraction.dart';
import 'package:tour_aid/screens/home/explore.dart';
import 'package:tour_aid/utils/colors.dart';

class AttractionDetail extends StatelessWidget {
  final site;

  AttractionDetail({required this.site});

  @override
  Widget build(BuildContext context) {
    // Sample data for demonstration.
    final String imageUrl = site['primaryImage'];
    final String name = site['name'];
    final String description = site['description'];
    final String website = site['websiteUrl'];
    final String phoneNumber = site['phoneNumber'];
    final additionalImages = site['additionalImages'];
    return Scaffold(
      body: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height / 3,
          child: Stack(
            children: [
              Image.network(
                imageUrl,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  // Description
                  Text(
                    description,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  // Website URL
                  Text(
                    "Website: $website",
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                  SizedBox(height: 8),
                  // Phone number
                  Text(
                    "Phone: $phoneNumber",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  // Additional images
                  Text(
                    "Additional Images",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  // Horizontal scrollable list of additional images
                  SizedBox(
                    height: 100, // Set a fixed height for the horizontal list
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: additionalImages.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            width: 100, // Set a fixed width for the containers
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
                                width: double.infinity, // Fill the container
                                fit: BoxFit
                                    .cover, // Ensure the image covers the area
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
      // Content below the image
      // Primary image that takes half of the screen
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the map page with location details
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExploreScreen(
                  site: site), // Replace with your actual MapPage widget
            ),
          );
        },
        child: MyElevatedButton(
          onPressed: () {},
          radius: 5.0,
          width: double.infinity,
          backgroundColor: AppColors.indicatorActive,
          child: MyText(
              text: 'Locate on Map',
              color: AppColors.primaryWhite,
              weight: FontWeight.w600,
              align: TextAlign.center,
              size: 17),
        ),
      ),
    );
  }
}
