import 'package:flutter/material.dart';
import 'package:tour_aid/models/attraction.dart';
import 'package:tour_aid/screens/home/attraction_detail.dart';
import 'package:tour_aid/services/attractions.dart';

class AttractionSitesDisplay extends StatefulWidget {
  const AttractionSitesDisplay({super.key});

  @override
  State<AttractionSitesDisplay> createState() => _AttractionSitesDisplayState();
}

class _AttractionSitesDisplayState extends State<AttractionSitesDisplay>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> categories = [
    'All',
    'Parks',
    'Museums',
    'Restaurants'
  ]; // Example categories
  List<AttractionSite> attractionSites = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
    fetchAttractionSites();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> fetchAttractionSites() async {
    final ListOfAttractionSites =
        await AttractionService().fetchAttractionSites();

    setState(() {
      attractionSites = ListOfAttractionSites;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: categories.map((category) => Tab(text: category)).toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: categories.map((category) {
              return ListView.builder(
                itemCount: attractionSites.length,
                itemBuilder: (context, index) {
                  final site = attractionSites[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AttractionDetail(site: site),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Container for the image with padding
                          Container(
                            padding: const EdgeInsets.all(
                                8.0), // Add padding around the image
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  8.0), // Optional: add rounded corners
                              child: Image.network(
                                site.primaryImage, // Assuming 'imageUrl' is the field name
                                height: 150, // Set your preferred height
                                width: double.infinity,
                                fit: BoxFit
                                    .cover, // Ensure the image covers the area
                              ),
                            ),
                          ),
                          // Name below the image
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              site.name, // Assuming 'name' is the field name
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // Category name as subtitle
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 8.0),
                            child: Text(
                              site.categoryName,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
