import 'package:chat_app/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({
    super.key,
    required this.userEmail,
  });
  
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.goNamed(
          AppRoute.chatRoom.name,
          pathParameters: {'userEmail': userEmail},
        );
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              const SizedBox(width: 16),
              Text(
                userEmail,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
