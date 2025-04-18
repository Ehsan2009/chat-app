// import 'package:chat_app/src/app.dart';
// import 'package:chat_app/src/common_widgets/custom_text_form_field.dart';
// import 'package:chat_app/src/features/authentication/domain/app_user.dart';
// import 'package:chat_app/src/features/authentication/presentation/widgets/auth_submit_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// import '../test/src/mocks.dart';

// void main() {
//   final testEmail = 'test@example.com';
//   final testPassword = '12345678';
//   final secondTestEmail = 'secondtest@example.com';
//   final secondTestPassword = 'lksjgoiqhai';
//   final firstUser = AppUser(id: 'user1', email: 'first@example.com');
//   final secondUser = AppUser(id: 'user2', email: 'second@example.com');

//   late MockAuthRepository mockAuthRepository;
//   late MockChatRepository mockChatRepository;

//   setUpAll(() {
//     mockAuthRepository = MockAuthRepository();
//     mockChatRepository = MockChatRepository();
//   });

//   testWidgets('Integration test - Full chat flow', (tester) async {
//     when(
//       () => mockAuthRepository.createUserWithEmailAndPassword(any(), any()),
//     ).thenAnswer((_) => Future.value());
//     when(() => mockAuthRepository.currentUser).thenReturn(firstUser);
//     when(
//       () => mockChatRepository.storeUserEmail(any(), any()),
//     ).thenAnswer((_) async => Future.value());
//     when(
//       () => mockChatRepository.fetchUsersEmail(firstUser.email),
//     ).thenAnswer((_) async => [secondUser.email]);
//     // when(() => mockChatRepository.sendMessage(any())).thenAnswer((_) => Future.value());
//     // when(() => mockChatRepository.watchMessages(any())).thenAnswer((_) => ['Hello']);

//     await tester.pumpWidget(ProviderScope(child: MyApp()));
//     await tester.pumpAndSettle();

//     final emailField = find.byType(CustomTextFormField).first;
//     final passwordField = find.byType(CustomTextFormField).at(1);
//     final confirmPasswordField = find.byType(CustomTextFormField).last;

//     // creating first user
//     await tester.enterText(emailField, testEmail);
//     await tester.enterText(passwordField, testPassword);
//     await tester.enterText(confirmPasswordField, testPassword);
//     await tester.tap(find.byType(AuthSubmitButton));
//     await tester.pumpAndSettle();

//     expect(find.text('U S E R S'), findsOneWidget);

//     // logging out
//     await tester.tap(find.byIcon(Icons.menu));
//     await tester.pumpAndSettle();
//     await tester.tap(find.text('L O G O U T'));
//     await tester.pumpAndSettle();

//     expect(find.text('Sign up'), findsOneWidget);

//     // creating another account to message
//     await tester.enterText(emailField, secondTestEmail);
//     await tester.enterText(passwordField, secondTestPassword);
//     await tester.enterText(confirmPasswordField, secondTestPassword);
//     await tester.tap(find.byType(AuthSubmitButton));
//     await tester.pumpAndSettle();

//     expect(find.text(testEmail), findsOneWidget);

//     // starting chat
//     await tester.tap(find.text(testEmail));
//     await tester.pumpAndSettle();

//     expect(find.text('There is not message here'), findsOneWidget);

//     final messageField = find.byType(CustomTextFormField);

//     await tester.enterText(messageField, 'Hello');
//     await tester.tap(find.byType(FloatingActionButton));
//     await tester.pumpAndSettle();

//     expect(find.text('Hello'), findsOneWidget);
//   });
// }
