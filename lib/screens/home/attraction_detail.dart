import 'package:flutter/material.dart';

class AttractionDetail extends StatelessWidget {
  final String siteId;
  const AttractionDetail({
    super.key,
    required this.siteId
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attraction Details'),
      ),
      body: Center(
        child: Text('Details for attraction ID: $siteId'),
      ),
    );
  }
}
