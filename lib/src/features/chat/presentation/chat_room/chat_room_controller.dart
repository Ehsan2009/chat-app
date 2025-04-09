import 'package:chat_app/src/features/chat/application/chat_service.dart';
import 'package:chat_app/src/features/chat/data/chat_repository.dart';
import 'package:chat_app/src/features/chat/domain/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_room_controller.g.dart';

@riverpod
class ChatRoomController extends _$ChatRoomController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<void> sendMessage(
      Message message) async {
    state = const AsyncLoading();

    final chatRepository = ref.read(chatRepositoryProvider);

    try {
      await chatRepository.sendMessage(message);
      state = const AsyncData(null);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  String generateRoomId(String currentContactEmail) {
    final chatService = ref.read(chatServiceProvider);
    return chatService.generateRoomId(currentContactEmail);
  }

    Stream<QuerySnapshot> getMessages(String roomID) {
    return ref.read(chatRepositoryProvider).getMessages(roomID);
  }
}
