import 'package:firebase_auth/firebase_auth.dart';

typedef UserID = String;

class AppUser {
  final UserID id;
  final String email;

  AppUser({required this.id, required this.email});

    factory AppUser.fromFirebaseUser(User firebaseUser) {
    return AppUser(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
    );
  }
}
