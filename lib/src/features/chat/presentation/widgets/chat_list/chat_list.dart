import 'package:chat_app/src/common_widgets/responsive_center.dart';
import 'package:chat_app/src/constants/breakpoints.dart';
import 'package:chat_app/src/features/chat/application/chat_service.dart';
import 'package:chat_app/src/features/chat/presentation/widgets/chat_list/chat_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatList extends ConsumerWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<String>>(
      future: ref.watch(chatServiceProvider).fetchUsers(),
      builder: (context, snapshot) {

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary,
            ),
          );
        }

        if (snapshot.hasData) {
          final users = snapshot.data!;
          return ResponsiveCenter(
            maxContentWidth: Breakpoint.tablet,
            child: Material(
              color: Theme.of(context).colorScheme.surface,
              elevation: 80,
              shadowColor: Theme.of(context).colorScheme.secondary,
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (ctx, index) {
                  return ChatListItem(userEmail: users[index]);
                },
              ),
            ),
          );
        }

        return Center(
          child: Text(
            'No users available',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        );
      },
    );
  }
}
