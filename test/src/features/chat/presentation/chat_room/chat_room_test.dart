// import 'dart:async';

// import 'package:chat_app/src/common_widgets/custom_text_form_field.dart';
// import 'package:chat_app/src/features/authentication/data/auth_repository.dart';
// import 'package:chat_app/src/features/authentication/domain/app_user.dart';
// import 'package:chat_app/src/features/chat/data/chat_repository.dart';
// import 'package:chat_app/src/features/chat/domain/message.dart';
// import 'package:chat_app/src/features/chat/presentation/chat_room/chat_room.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// import '../../../../mocks.dart';

// void main() {
//   const currentContact = 'napem98@gmail.com';
//   final currentUser = AppUser(id: '123', email: 'ehsanjavdan77@gmail.com');

//   final message = Message(
//     content: 'Hello',
//     senderID: currentUser.id,
//     roomID: 'napem98@gmail.com-ehsanjavdan77@gmail.com',
//     timestamp: DateTime.now(),
//   );

//   final controller = StreamController<List<Message>>.broadcast();

//   late MockAuthRepository mockAuthRepository;
//   late MockChatRepository mockChatRepository;

//   setUp(() {
//     mockAuthRepository = MockAuthRepository();
//     mockChatRepository = MockChatRepository();
//   });

//   testWidgets('sending message and displaying on screen', (tester) async {
//     when(() => mockAuthRepository.currentUser).thenReturn(currentUser);
//     when(
//       () => mockChatRepository.sendMessage(message),
//     ).thenAnswer((_) async {});
//     when(
//       () => mockChatRepository.watchMessages(any()),
//     ).thenAnswer((_) => controller.stream);
//     controller.add([]);
    
//     addTearDown(controller.close);

//     await tester.pumpWidget(
//       ProviderScope(
//         overrides: [
//           authRepositoryProvider.overrideWithValue(mockAuthRepository),
//           chatRepositoryProvider.overrideWithValue(mockChatRepository),
//         ],
//         child: MaterialApp(home: ChatRoom(currentContact: currentContact)),
//       ),
//     );
//     await tester.pumpAndSettle();

//     expect(find.text('There is no message here'), findsOneWidget);

//     final messageField = find.byType(CustomTextFormField);

//     await tester.enterText(messageField, 'Hello');
//     await tester.tap(find.byType(FloatingActionButton));
//     controller.add([message]);
//     await tester.pumpAndSettle();

//     expect(find.text('Hello'), findsOneWidget);
//   });
// }
