import 'package:chat_app/src/common_widgets/custom_drawer.dart';
import 'package:chat_app/src/common_widgets/custom_text_form_field.dart';
import 'package:chat_app/src/constants/breakpoints.dart';
import 'package:chat_app/src/features/authentication/data/auth_repository.dart';
import 'package:chat_app/src/features/chat/domain/message.dart';
import 'package:chat_app/src/features/chat/presentation/chat_list/chat_list.dart';
import 'package:chat_app/src/features/chat/presentation/chat_room/chat_room_controller.dart';
import 'package:chat_app/src/features/chat/presentation/chat_room/chat_messages.dart';
import 'package:chat_app/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChatRoom extends ConsumerWidget {
  const ChatRoom({super.key, required this.currentContact});

  final String? currentContact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chatRoomControllerProvider);
    final chatRoomController = ref.read(chatRoomControllerProvider.notifier);
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    final width = MediaQuery.of(context).size.width;
    final isMobile = width <= Breakpoint.tablet;
    var messageController = TextEditingController();
    String roomID = chatRoomController.generateRoomId(currentContact ?? '');

    void sendMessage(Message message) async {
      chatRoomController.sendMessage(message);

      messageController.clear();
    }

    if (currentContact == null) {
      return Center(
        child: Text(
          'Choose an user to message!',
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer:
          isMobile ? null : const CustomDrawer(currentSection: Section.home),
      appBar:
          isMobile
              ? null
              : AppBar(backgroundColor: Theme.of(context).colorScheme.surface),
      body: SafeArea(
        child: Row(
          children: [
            if (!isMobile) const Expanded(flex: 1, child: ChatList()),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        if (isMobile)
                          GestureDetector(
                            onTap: () {
                              context.goNamed(AppRoute.chat.name);
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        const Spacer(),
                        Text(
                          currentContact!,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: ChatMessages(roomID: roomID)),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            controller: messageController,
                            hintText: 'Type a message',
                          ),
                        ),
                        const SizedBox(width: 16),
                        FloatingActionButton(
                          onPressed: () {
                            if (messageController.text.isEmpty) {
                              return;
                            }
                            sendMessage(
                              Message(
                                content: messageController.text,
                                roomID: roomID,
                                senderID: currentUser!.id,
                                timestamp: DateTime.now(),
                              ),
                            );
                          },
                          elevation: 0,
                          shape: const CircleBorder(),
                          backgroundColor: Colors.green,
                          child:
                              state.isLoading
                                  ? CircularProgressIndicator(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  )
                                  : const Icon(
                                    Icons.arrow_upward_outlined,
                                    color: Colors.white,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
