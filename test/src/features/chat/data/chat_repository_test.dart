import 'package:chat_app/src/features/chat/data/chat_repository.dart';
import 'package:chat_app/src/features/chat/domain/message.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const testRoomId = '123456';
  const testId = '1234';
  const testEmail = 'test@example.com';

  final message = Message(
    content: 'Hello',
    roomID: testRoomId,
    senderID: '123456',
    timestamp: DateTime.now(),
  );

  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late ChatRepository chatRepository;

  setUp(() {
    fakeFirebaseFirestore = FakeFirebaseFirestore();
    chatRepository = ChatRepository(fakeFirebaseFirestore);
  });

  group('ChatRepository', () {
    test('should send a message and store it in Firebase', () async {
      await chatRepository.sendMessage(message);

      final List<Map<String, dynamic>> actualDataList =
          (await fakeFirebaseFirestore
                  .collection('chatRooms')
                  .doc(message.roomID)
                  .collection('messages')
                  .get())
              .docs
              .map((e) => e.data())
              .toList();

      expect(actualDataList.length, 1);
      expect(actualDataList.first['content'], 'Hello');
    });

    test('should fetch users email except current user', () async {
      await fakeFirebaseFirestore.collection('users').doc(testId).set({
        'email': testEmail,
      });

      await fakeFirebaseFirestore.collection('users').doc('1').set({
        'email': 'ehsanjavdan77@gmail.com',
      });

      final usersEmail = await chatRepository.fetchUsersEmail(
        'ehsanjavdan77@gmail.com',
      );

      expect(usersEmail, contains(testEmail));
    });

    test('should store user email in Firebase', () async {
      await chatRepository.storeUserEmail(testId, testEmail);

      final userEmail =
          (await fakeFirebaseFirestore.collection('users').get()).docs
              .map((e) => e.data())
              .toList();

      expect(userEmail.first['email'], testEmail);
    });

    test(
      'should fetch a stream of chat messages for a specific chat room',
      () async {
        await fakeFirebaseFirestore
            .collection('chatRooms')
            .doc(message.roomID)
            .collection('messages')
            .add(message.toJson());

        final watchMessagesStream = chatRepository.watchMessages(testRoomId);

        final messages = await watchMessagesStream.first;
        expect(messages.first.content, message.content);
      },
    );
  });
}
