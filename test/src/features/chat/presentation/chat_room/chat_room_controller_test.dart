import 'package:chat_app/src/features/authentication/data/auth_repository.dart';
import 'package:chat_app/src/features/authentication/domain/app_user.dart';
import 'package:chat_app/src/features/chat/data/chat_repository.dart';
import 'package:chat_app/src/features/chat/domain/message.dart';
import 'package:chat_app/src/features/chat/presentation/chat_room/chat_room_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  const testId = '123';
  const testEmail = 'test@example.com';
  const currentContactEmail = 'current@contact.com';

  final message = Message(
    content: 'Hello',
    roomID: '123456',
    senderID: testId,
    timestamp: DateTime.now(),
  );

  late MockChatRepository mockChatRepository;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockChatRepository = MockChatRepository();
    mockAuthRepository = MockAuthRepository();
  });

  group('ChatRoomController', () {
    test(
      '''
given mockChatRepository
when calling sendMessage() on ChatRoomController
then sendMessage() on mockChatRepository should be called
''',
      () async {
        when(
          () => mockChatRepository.sendMessage(message),
        ).thenAnswer((_) async => Future.value());

        final container = ProviderContainer(
          overrides: [
            chatRepositoryProvider.overrideWithValue(mockChatRepository),
          ],
        );

        await container
            .read(chatRoomControllerProvider.notifier)
            .sendMessage(message);

        verify(() => mockChatRepository.sendMessage(message)).called(1);
      },
    );

    test(
      '''
given mockAuthRepository
when calling generateRoomId() on chatRoomController
then it should return a roomId
''',
      () async {
        when(
          () => mockAuthRepository.currentUser,
        ).thenReturn(AppUser(id: testId, email: testEmail));

        final container = ProviderContainer(
          overrides: [
            authRepositoryProvider.overrideWithValue(mockAuthRepository),
          ],
        );

        final roomId = container
            .read(chatRoomControllerProvider.notifier)
            .generateRoomId(currentContactEmail);

        expect(roomId, isA<String>());
      },
    );
  });
}
