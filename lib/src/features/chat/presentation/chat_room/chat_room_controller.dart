import 'package:chat_app/src/features/authentication/data/auth_repository.dart';
import 'package:chat_app/src/features/chat/data/chat_repository.dart';
import 'package:chat_app/src/features/chat/domain/message.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_room_controller.g.dart';

@riverpod
class ChatRoomController extends _$ChatRoomController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<void> sendMessage(Message message) async {
    final chatRepository = ref.read(chatRepositoryProvider);

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      chatRepository.sendMessage(message);
    });
  }

  String generateRoomId(String currentContactEmail) {
    final authRepository = ref.read(authRepositoryProvider);
    final currentUserEmail = authRepository.currentUser!.email;

    List<String> ids = [
      currentUserEmail,
      currentContactEmail.toLowerCase().trim(),
    ];
    ids.sort();
    return ids.join('_');
  }
}
