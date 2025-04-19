// import 'dart:io';

// import 'package:chat_app/src/app.dart';
// import 'package:chat_app/src/common_widgets/custom_text_form_field.dart';
// import 'package:chat_app/src/features/authentication/data/auth_repository.dart';
// import 'package:chat_app/src/features/authentication/domain/app_user.dart';
// import 'package:chat_app/src/features/authentication/presentation/widgets/auth_submit_button.dart';
// import 'package:chat_app/src/features/chat/data/chat_repository.dart';
// import 'package:chat_app/src/features/settings/data/settings_repository.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:hive/hive.dart';
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
//   late MockSettingsRepository mockSettingsRepository;

//   setUpAll(() async {
//     final testDir = await Directory.systemTemp.createTemp();
//     Hive.init(testDir.path);
//     await Hive.openBox('settings');

//     mockAuthRepository = MockAuthRepository();
//     mockChatRepository = MockChatRepository();
//     mockSettingsRepository = MockSettingsRepository();
//   });

//   tearDownAll(() async {
//     await Hive.close();
//   });

//   testWidgets('Integration test - Full chat flow', (tester) async {
//     // Step 1: App starts with no user logged in
//     when(() => mockAuthRepository.currentUser).thenReturn(null);
//     when(
//       () => mockAuthRepository.watchAuthStateChanges(),
//     ).thenAnswer((_) => Stream.value(null));

//     when(
//       () => mockSettingsRepository.themeMode(),
//     ).thenAnswer((_) async => ThemeMode.dark);

//     await tester.pumpWidget(
//       ProviderScope(
//         overrides: [
//           authRepositoryProvider.overrideWithValue(mockAuthRepository),
//           chatRepositoryProvider.overrideWithValue(mockChatRepository),
//           settingsRepositoryProvider.overrideWithValue(mockSettingsRepository),
//         ],
//         child: MyApp(),
//       ),
//     );
//     await tester.pumpAndSettle();

//     await tester.tap(find.text('Register now'));
//     await tester.pumpAndSettle();

//     expect(find.byType(CustomTextFormField), findsNWidgets(3));

//     final emailField = find.byType(CustomTextFormField).first;
//     final passwordField = find.byType(CustomTextFormField).at(1);
//     final confirmPasswordField = find.byType(CustomTextFormField).last;

//     // creating first user
//     await tester.enterText(emailField, testEmail);
//     await tester.enterText(passwordField, testPassword);
//     await tester.enterText(confirmPasswordField, testPassword);
//     await tester.pumpAndSettle(const Duration(seconds: 5));
//     await tester.tap(find.byType(AuthSubmitButton));

//     // Now simulate that user is logged in
//     when(() => mockAuthRepository.currentUser).thenReturn(firstUser);
//     when(
//       () => mockAuthRepository.watchAuthStateChanges(),
//     ).thenAnswer((_) => Stream.value(firstUser));
//     when(
//       () => mockChatRepository.storeUserEmail(any(), any()),
//     ).thenAnswer((_) async => Future.value());

//     when(
//       () => mockChatRepository.fetchUsersEmail(secondUser.email),
//     ).thenAnswer((_) async => []);

//     await tester.pumpAndSettle(const Duration(seconds: 5));

//     expect(find.text('U S E R S'), findsOneWidget);

//     // logging out
//     await tester.tap(find.byIcon(Icons.menu));
//     await tester.pumpAndSettle();
//     await tester.tap(find.text('L O G O U T'));

//     // Simulate no user again
//     when(() => mockAuthRepository.currentUser).thenReturn(null);
//     when(
//       () => mockAuthRepository.watchAuthStateChanges(),
//     ).thenAnswer((_) => Stream.value(null));

//     await tester.pumpAndSettle();

//     expect(find.text('Sign up'), findsOneWidget);

//     // creating another account to message
//     await tester.enterText(emailField, secondTestEmail);
//     await tester.enterText(passwordField, secondTestPassword);
//     await tester.enterText(confirmPasswordField, secondTestPassword);
//     await tester.tap(find.byType(AuthSubmitButton));

//     // Simulate that second user is now logged in
//     when(() => mockAuthRepository.currentUser).thenReturn(secondUser);
//     when(
//       () => mockAuthRepository.watchAuthStateChanges(),
//     ).thenAnswer((_) => Stream.value(secondUser));

//     when(
//       () => mockChatRepository.fetchUsersEmail(secondUser.email),
//     ).thenAnswer((_) async => [testEmail]);

//     await tester.pumpAndSettle();

//     expect(find.text(testEmail), findsOneWidget);

//     await tester.pumpAndSettle();

//     // starting chat
//     // await tester.tap(find.text(testEmail));
//     // await tester.pumpAndSettle();

//     // expect(find.text('There is not message here'), findsOneWidget);

//     // final messageField = find.byType(CustomTextFormField);

//     // await tester.enterText(messageField, 'Hello');
//     // await tester.tap(find.byType(FloatingActionButton));
//     // await tester.pumpAndSettle();

//     // expect(find.text('Hello'), findsOneWidget);
//   });
// }

