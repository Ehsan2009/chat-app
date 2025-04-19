import 'package:chat_app/src/common_widgets/custom_text_form_field.dart';
import 'package:chat_app/src/features/authentication/data/auth_repository.dart';
import 'package:chat_app/src/features/authentication/domain/app_user.dart';
import 'package:chat_app/src/features/authentication/presentation/register_screen.dart';
import 'package:chat_app/src/features/authentication/presentation/widgets/auth_submit_button.dart';
import 'package:chat_app/src/features/chat/data/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, __) => RegisterScreen()),
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
  final testId = '123';

  late MockAuthRepository mockAuthRepository;
  late MockChatRepository mockChatRepository;
  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockChatRepository = MockChatRepository();
  });

  group('RegisterScreen', () {
    testWidgets(
      '''
given mockAuthRepository
when filling inputs and tapping sign up button
then authRepository.createUserWithEmailAndPassword() should be called
''',
      (tester) async {
        when(
          () => mockAuthRepository.createUserWithEmailAndPassword(
            testEmail,
            testPassword,
          ),
        ).thenAnswer((_) async => Future.value());

        when(
          () => mockAuthRepository.currentUser,
        ).thenReturn(AppUser(id: testId, email: testEmail));

        when(
          () => mockChatRepository.storeUserEmail(any(), any()),
        ).thenAnswer((_) async => Future.value());

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              authRepositoryProvider.overrideWithValue(mockAuthRepository),
              chatRepositoryProvider.overrideWithValue(mockChatRepository),
            ],
            child: MaterialApp.router(routerConfig: router),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(AuthSubmitButton));
        await tester.pumpAndSettle();
        verifyNever(() => mockAuthRepository.createUserWithEmailAndPassword(any(), any()));

        final emailField = find.byType(CustomTextFormField).first;
        final passwordField = find.byType(CustomTextFormField).at(1);
        final confirmPasswordField = find.byType(CustomTextFormField).last;

        await tester.enterText(emailField, testEmail);
        await tester.enterText(passwordField, testPassword);
        await tester.enterText(confirmPasswordField, testPassword);
        await tester.tap(find.byType(AuthSubmitButton));
        await tester.pumpAndSettle();

        verify(
          () => mockAuthRepository.createUserWithEmailAndPassword(
            testEmail,
            testPassword,
          ),
        ).called(1);
      },
    );
  });
}
