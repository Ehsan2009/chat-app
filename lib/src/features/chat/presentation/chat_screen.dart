import 'package:chat_app/src/common_widgets/custom_drawer.dart';
import 'package:chat_app/src/constants/breakpoints.dart';
import 'package:chat_app/src/features/chat/presentation/chat_list/chat_list.dart';
import 'package:chat_app/src/features/chat/presentation/chat_room/chat_room.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
    this.currentContact,
  });

  final String? currentContact;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width <= Breakpoint.tablet;

    if (isMobile && currentContact == null) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        drawer: const CustomDrawer(
          currentSection: Section.home,
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text(
            'U S E R S',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          centerTitle: true,
        ),
        body: const ChatList(),
      );
    }

    if (isMobile && currentContact != null) {
      return ChatRoom(currentContact: currentContact);
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: const CustomDrawer(
        currentSection: Section.home,
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Row(
        spacing: 100,
        children: [
          const Expanded(
            flex: 1,
            child: ChatList(),
          ),
          Expanded(
            flex: 2,
            child: ChatRoom(currentContact: currentContact),
          )
        ],
      ),
    );
  }
}
