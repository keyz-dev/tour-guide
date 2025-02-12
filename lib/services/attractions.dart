import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/attraction.dart';

class AttractionService {
  // For storing data in the firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> createAttractionSite(AttractionSite attractionSite) async {
    try {
      await _firestore
          .collection('attraction_sites')
          .add(attractionSite.toMap());
      return null; // Success
    } catch (e) {
      return e.toString();
    }
  }
}
