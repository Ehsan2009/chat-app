import 'package:chat_app/src/common_widgets/custom_text_form_field.dart';
import 'package:chat_app/src/features/authentication/data/auth_repository.dart';
import 'package:chat_app/src/features/authentication/presentation/sign_in_screen.dart';
import 'package:chat_app/src/features/authentication/presentation/widgets/auth_submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

final testRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, __) => SignInScreen()),
    GoRoute(
      name: 'chat',
      path: '/chat',
      builder: (_, __) => const SizedBox(), // dummy placeholder
    ),
  ],
);

void main() {
  final testEmail = 'test@example.com';
  final testPassword = '12345678';

  late MockAuthRepository mockAuthRepository;
  setUp(() {
    mockAuthRepository = MockAuthRepository();
  });

  group('SignInScreen', () {
    testWidgets(
      '''
given mockAuthRepository
when filling inputs and tapping Login button
then authRepository.signInWithEmailAndPassword() should be called
''',
      (tester) async {
        when(
          () => mockAuthRepository.signInWithEmailAndPassword(
            testEmail,
            testPassword,
          ),
        ).thenAnswer((_) async => Future.value());

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              authRepositoryProvider.overrideWithValue(mockAuthRepository),
            ],
            child: MaterialApp.router(routerConfig: testRouter),
          ),
        );
        await tester.pumpAndSettle();

        final emailField = find.byType(CustomTextFormField).first;
        final passwordField = find.byType(CustomTextFormField).at(1);

        await tester.enterText(emailField, testEmail);
        await tester.enterText(passwordField, testPassword);
        await tester.tap(find.byType(AuthSubmitButton));
        await tester.pumpAndSettle();

        verify(
          () => mockAuthRepository.signInWithEmailAndPassword(
            testEmail,
            testPassword,
          ),
        ).called(1);
      },
    );
  });
}
