import 'package:chat_app/src/common_widgets/responsive_center.dart';
import 'package:chat_app/src/constants/breakpoints.dart';
import 'package:chat_app/src/features/chat/application/users_list_provider.dart';
import 'package:chat_app/src/features/chat/presentation/chat_list/chat_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatList extends ConsumerWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(fetchUsersProvider);

    return usersAsync.when(
      data: (users) {
        if (users.isEmpty) {
          Center(
            child: Text(
              'No users available',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
          );
        }

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
      },
      error: (error, _) => Center(child: Text(error.toString())),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
