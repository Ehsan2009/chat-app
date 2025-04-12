import 'package:chat_app/src/features/authentication/data/auth_repository.dart';
import 'package:chat_app/src/features/authentication/presentation/auth_controller.dart';
import 'package:chat_app/src/features/chat/data/chat_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

class AuthService {
  AuthService(this._ref);
  final Ref _ref;

  Future<void> authenticate(
    String email,
    String password,
    EmailPasswordSignInFormType formType,
  ) async {
    final authRepository = _ref.read(authRepositoryProvider);
    final chatRepository = _ref.read(chatRepositoryProvider);

    if (formType == EmailPasswordSignInFormType.signIn) {
      await authRepository.signInWithEmailAndPassword(email, password);
    } else {
      await authRepository.createUserWithEmailAndPassword(email, password);
      final currentUser = authRepository.currentUser;
      await chatRepository.storeUserEmail(currentUser!.id, email);
    }
  }
}

@riverpod
AuthService authService(Ref ref) {
  return AuthService(ref);
}
