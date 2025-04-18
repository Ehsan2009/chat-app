import 'package:chat_app/src/features/authentication/data/auth_repository.dart';
import 'package:chat_app/src/features/chat/data/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatMessages extends ConsumerWidget {
  const ChatMessages({super.key, required this.roomID});

  final String roomID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    final chatMessagesAsync = ref.watch(messagesListStreamProvider(roomID));

    return chatMessagesAsync.when(
      data: (messages) {
        if (messages.isEmpty) {
          return Center(
            child: Text(
              'There is no message here',
              style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 40),
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            var content = messages[index].content;
            var senderID = messages[index].senderID;

            bool isMe = currentUser!.id == senderID;

            return Align(
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:
                      isMe
                          ? Theme.of(context).colorScheme.primaryContainer
                          : Theme.of(context).colorScheme.primary,
                  // : Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.only(
                    topLeft: !isMe ? Radius.zero : const Radius.circular(12),
                    topRight: isMe ? Radius.zero : const Radius.circular(12),
                    bottomLeft: const Radius.circular(12),
                    bottomRight: const Radius.circular(12),
                  ),
                ),
                child: Text(
                  content,
                  softWrap: true,
                  style: TextStyle(
                    color:
                        isMe
                            ? Theme.of(context).colorScheme.onPrimaryContainer
                            : Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            );
          },
        );
      },
      error: (error, _) => Center(child: Text(error.toString())),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
