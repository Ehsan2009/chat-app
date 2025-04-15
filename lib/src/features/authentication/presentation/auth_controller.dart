import 'package:chat_app/src/features/authentication/application/auth_service.dart';
import 'package:chat_app/src/features/authentication/data/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

enum EmailPasswordSignInFormType { signIn, register }

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<void> authenticate(
    String email,
    String password,
    EmailPasswordSignInFormType formType,
  ) async {
    final authService = ref.read(authServiceProvider);

    state = AsyncLoading();

    state = await AsyncValue.guard(() async {
      return authService.authenticate(email, password, formType);
    });
  }

  Future<void> signOut() async {
    final authRepository = ref.read(authRepositoryProvider);

    state = AsyncLoading();

    state = await AsyncValue.guard(authRepository.signOut);
  }
}
