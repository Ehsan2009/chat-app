import 'package:chat_app/src/features/authentication/data/auth_repository.dart';
import 'package:chat_app/src/features/authentication/presentation/auth_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<void> authenticate(String email, String password,
      EmailPasswordSignInFormType formType) async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncValue.loading();

    try {
      switch (formType) {
        case EmailPasswordSignInFormType.signIn:
          await authRepository.signInWithEmailAndPassword(email, password);
          break;
        case EmailPasswordSignInFormType.register:
          await authRepository.createUserWithEmailAndPassword(email, password);
          await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .set({
            'email': FirebaseAuth.instance.currentUser!.email,
          });
          break;
      }
      state = const AsyncValue.data(null);
    } on FirebaseAuthException catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
