import 'package:chat_app/src/features/authentication/application/auth_service.dart';
import 'package:chat_app/src/features/authentication/data/auth_repository.dart';
import 'package:chat_app/src/features/authentication/presentation/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

void main() {
  late MockAuthService mockAuthService;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthService = MockAuthService();
    mockAuthRepository = MockAuthRepository();
  });

  group('AuthController', () {
    final email = 'test@example.com';
    final password = '123456';
    final formType = EmailPasswordSignInFormType.signIn;

    test(
      '''
given mockAuthService
when calling authenticate() method on AuthController
then authenticate() method on AuthService should be called
''',
      () async {
        when(
          () => mockAuthService.authenticate(email, password, formType),
        ).thenAnswer((_) async => Future.value());

        final container = ProviderContainer(
          overrides: [authServiceProvider.overrideWithValue(mockAuthService)],
        );

        addTearDown(container.dispose);

        final contorller = container.read(authControllerProvider.notifier);

        await contorller.authenticate(email, password, formType);

        verify(
          () => mockAuthService.authenticate(email, password, formType),
        ).called(1);
      },
    );

    test(
      '''
given mockAuthRepository
when calling signOut() method on AuthController
then signOut() method on AuthRepository should be called
''',
      () async {
        when(
          () => mockAuthRepository.signOut(),
        ).thenAnswer((_) async => Future.value());

        final container = ProviderContainer(
          overrides: [
            authRepositoryProvider.overrideWithValue(mockAuthRepository),
          ],
        );

        addTearDown(container.dispose);

        final controller = container.read(authControllerProvider.notifier);

        await controller.signOut();

        verify(() => mockAuthRepository.signOut()).called(1);
      },
    );
  });
}
