import 'package:chat_app/src/features/authentication/data/auth_repository.dart';
import 'package:chat_app/src/features/chat/data/chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_service.g.dart';

class ChatService {
  ChatService(this._ref);
  final Ref _ref;

  Stream<QuerySnapshot> getMessages(String roomID) {
    return _ref.read(chatRepositoryProvider).getMessages(roomID);
  }

  String generateRoomId(String currentUserID, String otherUserID) {
    List<String> ids = [
      currentUserID.toLowerCase().trim(),
      otherUserID.toLowerCase().trim()
    ];
    ids.sort();
    return ids.join('_');
  }

  Future<List<String>> fetchUsers() async {
    try {
      final chatRepository = _ref.watch(chatRepositoryProvider);
      String currentUserEmail = _ref.watch(authRepositoryProvider).currentUser!.email;
      
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
