import 'package:chat_app/src/features/authentication/application/auth_service.dart';
import 'package:chat_app/src/features/authentication/data/auth_repository.dart';
import 'package:chat_app/src/features/authentication/presentation/auth_controller.dart';
import 'package:chat_app/src/features/authentication/presentation/auth_screen.dart';
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

  group(
    'Test authenticate and signOut methods in auth controller provider',
    () {
      final email = 'test@example.com';
      final password = '123456';
      final formType = EmailPasswordSignInFormType.signIn;

      test(
        'Test authenticate method returns a successful future value',
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

          final state = container.read(authControllerProvider);
          expect(state, const AsyncData<void>(null));
        },
      );

      test('signOut method should call authRepository.signOut', () async {
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

        final state = container.read(authControllerProvider);
        expect(state, const AsyncData<void>(null));
        verify(() => mockAuthRepository.signOut()).called(1);
      });
    },
  );
}
