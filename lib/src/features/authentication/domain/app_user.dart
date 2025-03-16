import 'package:firebase_auth/firebase_auth.dart';

typedef UserID = String;

class AppUser {
  final UserID id;
  final String email;

  AppUser({required this.id, required this.email});

  // Convert Firebase user to AppUser
    factory AppUser.fromFirebaseUser(User firebaseUser) {
    return AppUser(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
    );
  }

  // Convert to JSON for Firestore
  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'email': email,
  //   };
  // }
}
