import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
    required File? profileImage,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // set the role
      String role = 'admin';
      // Upload profile picture
      String? profilePicUrl;
      if (profileImage != null) {
        profilePicUrl = await uploadProfilePicture(userCredential.user!.uid, profileImage);
      }

      // Create user model
      UserModel user = UserModel(
        id: userCredential.user!.uid,
        name: name,
        email: email,
        phone: phone,
        dob: dob,
        gender: gender,
        role: role,
        profileImage: profilePicUrl,
        city: city,
      );

      // Store in Firestore
      await _firestore.collection('users').doc(user.id).set(user.toMap());

      return null; // Success
    } catch (e) {
      return e.toString();
    }
  }

  // Upload Profile Picture
  Future<String> uploadProfilePicture(String userId, File image) async {
    Reference ref = _storage.ref().child('profile_pictures/$userId.jpg');
    await ref.putFile(image);
    return await ref.getDownloadURL();
  }

  // Sign-in user
  Future<String?> loginUser({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // Success
    } catch (e) {
      return e.toString();
    }
  }
  // Sign-out user
  Future<void> logoutUser() async {
    await _auth.signOut();
  }
}


