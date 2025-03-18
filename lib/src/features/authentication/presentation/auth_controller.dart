import 'package:chat_app/src/features/authentication/application/auth_service.dart';
import 'package:chat_app/src/features/authentication/presentation/auth_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

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

    state = const AsyncValue.loading();

    try {
      await authService.authenticate(email, password, formType);
      state = const AsyncValue.data(null); // Success
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
