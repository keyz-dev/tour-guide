import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tour_aid/services/cloudinary.dart';

import '../models/user.dart';

class AuthService {
  // For storing data in the firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //   For authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // for file storage
  final FirebaseStorage _storage = FirebaseStorage.instance;

  //Signup the user
  Future<String?> registerUser({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String city,
    required String dob,
    required String gender,
    required String profileImage,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // set the role
      String role = 'user';
      // Create user model
      UserModel user = UserModel(
        id: userCredential.user!.uid,
        name: name,
        email: email,
        phone: phone,
        dob: dob,
        gender: gender,
        role: role,
        profileImage: profileImage,
        city: city,
      );

      // Store in Firestore
      await _firestore.collection('users').doc(user.id).set(user.toMap());

      return null; // Success
    } catch (e) {
      return e.toString();
    }
  }

  /// Signs in the user using Firebase Authentication.
  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> fetchUserModel(String uid) async {
    try {
      DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
      // Check if the document exists
      if (userDoc.exists) {
        // Convert the document data to a map
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        // Use your fromMap factory to create an instance of UserModel
        UserModel user = UserModel.fromMap(data, userDoc.id);
        return user;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  /// Fetches the complete user model from Firestore.

  // Sign-out user
  Future<void> logoutUser() async {
    await _auth.signOut();
  }
}


