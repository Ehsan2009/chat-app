import 'package:chat_app/src/common_widgets/custom_text_form_field.dart';
import 'package:chat_app/src/features/authentication/presentation/auth_controller.dart';
import 'package:chat_app/src/features/authentication/presentation/auth_screen.dart';
import 'package:chat_app/src/features/authentication/presentation/widgets/auth_submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

void main() {
  late MockAuthController mockAuthController;

  setUp(() {
    mockAuthController = MockAuthController();
  });

  group('auth screen test', () {
    final email = 'test@example.com';
    final password = '123456';
    final formType = EmailPasswordSignInFormType.register;

    testWidgets(
      'when all inputs in register mode are filled, then by clicking sign up button, authController.authenticate() is called',
      (tester) async {
        when(() => mockAuthController.state).thenReturn(const AsyncData(null));
        when(
          () => mockAuthController.authenticate(email, password, formType),
        ).thenAnswer((_) async {});

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              authControllerProvider.overrideWith(() => mockAuthController),
            ],
            child: MaterialApp(home: AuthScreen()),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Confirm password'), findsOneWidget);

        final emailField = find.byType(CustomTextFormField).at(0);
        final passwordField = find.byType(CustomTextFormField).at(1);
        final confirmPasswordField = find.byType(CustomTextFormField).at(2);

        await tester.enterText(emailField, email);
        await tester.enterText(passwordField, password);
        await tester.enterText(confirmPasswordField, password);
        await tester.tap(find.byType(AuthSubmitButton));
        await tester.pumpAndSettle();

        verify(
          () => mockAuthController.authenticate(any(), any(), any()),
        ).called(1);
      },
    );
  });
}
