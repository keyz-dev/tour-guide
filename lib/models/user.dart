class UserModel {
  final String id; // Firestore document ID
  final String name;
  final String email;
  final String dob;
  final String gender;
  final String role;
  final String phone;
  final String city;
  final String? profileImage;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.dob,
    required this.gender,
    required this.role,
    required this.phone,
    required this.city,
    this.profileImage
  });

  // Convert the User object to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'dob': dob,
      'gender': gender,
      'role': role,
      'phone': phone,
      'city': city,
      'profileImage': profileImage
    };
  }

  // Create a User object from a Map (Firestore snapshot)
    factory UserModel.fromMap(Map<String, dynamic> map, String id) {
      return UserModel(
        id: id,
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        dob: map['dob'] ?? '',
        phone: map['phone'] ?? '',
        city: map['city'] ?? '',
        profileImage: map['profileImage'] ?? '',
        gender: map['gender'] ?? '',
        role: map['role'] ?? ''
      );
    }
}