class UserModel {
  String uid;
  String email;
  String name;
  String role; // 'tenant' or 'owner'
  String? phone;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.role,
    this.phone,
  });

  // Convert from Firestore document to UserModel
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return UserModel(
      uid: doc.id,
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      role: data['role'] ?? 'tenant', // Default to tenant if no role is found
      phone: data['phone'],
    );
  }

  // Convert UserModel to Firestore data
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'role': role,
      'phone': phone,
    };
  }
}