import 'package:chat_app/src/features/authentication/data/auth_repository.dart';
import 'package:chat_app/src/features/chat/data/chat_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_service.g.dart';

class ChatService {
  ChatService(this._ref);
  final Ref _ref;

  String generateRoomId(String currentContactEmail) {
    final authRepository = _ref.read(authRepositoryProvider);
    final currentUserEmail = authRepository.currentUser!.email;

    List<String> ids = [
      currentUserEmail,
      currentContactEmail.toLowerCase().trim(),
    ];
    ids.sort();
    return ids.join('_');
  }

  Future<List<String>> fetchUsers() async {
    try {
      final chatRepository = _ref.watch(chatRepositoryProvider);
      String currentUserEmail =
          _ref.watch(authRepositoryProvider).currentUser!.email;

      final users = await chatRepository.fetchUsersEmail(currentUserEmail);

      return users;
    } catch (error) {
      print(error);
      return [];
    }
  }
}

@riverpod
ChatService chatService(Ref ref) {
  return ChatService(ref);
}
