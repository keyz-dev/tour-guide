import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tour_aid/models/attraction.dart';
import 'package:tour_aid/screens/home/main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tour_aid/services/attractions.dart';

class ExploreScreen extends StatefulWidget {
  final AttractionSite? site;
  const ExploreScreen({super.key, this.site});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late Completer<GoogleMapController> _mapController = Completer();
  final CameraPosition _center = CameraPosition(
    target: LatLng(45.521563, -122.677433),
    zoom: 11.0,
  );
  final List<Marker> _markers = [];
  final List<Marker> _branches = [];
  final String _title = 'Explore';
  AttractionSite? _site;
  List<AttractionSite> attractionSites = [];

  @override
  void initState() {
    super.initState();

    if (widget.site != null) {
      _site = widget.site;
    } else {
      fetchAttractionSites();
    }
    setMarkers();
  }

  // Set the markers
  void setMarkers() {
    if (_site == null) {
      // Set markers on all the
      for (final site in attractionSites) {
        final marker = Marker(
          markerId: MarkerId(site.id!),
          position: LatLng(site.latitude, site.longitude),
          infoWindow: InfoWindow(title: site.name, snippet: site.name),
        );
        _branches.add(marker);
      }
    } else {
      final marker = Marker(
        markerId: MarkerId(_site!.id!),
        position: LatLng(_site!.latitude, _site!.longitude),
        infoWindow: InfoWindow(title: _site!.name, snippet: _site!.name),
      );
      _branches.add(marker);
    }
    _markers.addAll(_branches);
  }

  Future<void> fetchAttractionSites() async {
    final ListOfAttractionSites =
        await AttractionService().fetchAttractionSites();

    setState(() {
      attractionSites = ListOfAttractionSites;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
  }

  @override
  void dispose() {
    _mapController = Completer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Set the site variable

    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
      ),
      body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: _center,
          markers: Set<Marker>.of(_markers)),
    );
  }
}
