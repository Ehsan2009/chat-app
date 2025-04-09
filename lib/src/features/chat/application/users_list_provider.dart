import 'package:chat_app/src/features/authentication/data/auth_repository.dart';
import 'package:chat_app/src/features/chat/data/chat_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'users_list_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<String>> fetchUsers(Ref ref) async {
  final chatRepository = ref.watch(chatRepositoryProvider);
  String currentUserEmail =
      ref.watch(authRepositoryProvider).currentUser!.email;

  final users = await chatRepository.fetchUsersEmail(currentUserEmail);

  return users;
}
