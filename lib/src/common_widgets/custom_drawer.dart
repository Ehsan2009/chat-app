import 'package:chat_app/src/features/authentication/presentation/auth_controller.dart';
import 'package:chat_app/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum Section { home, settings }

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({super.key, required this.currentSection});

  final Section currentSection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 70,
          bottom: 30,
          right: 20,
          left: 20,
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/images/chat.png',
              width: 120,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 40),
            ListTile(
              onTap: () {
                context.goNamed(AppRoute.chat.name);
              },
              title: Text(
                'H O M E',
                style: TextStyle(
                  color:
                      currentSection == Section.home
                          ? Theme.of(context).colorScheme.secondary
                          : Colors.grey[600],
                ),
              ),
              leading: Icon(
                Icons.home,
                color:
                    currentSection == Section.home
                        ? Theme.of(context).colorScheme.secondary
                        : Colors.grey[600],
              ),
            ),
            ListTile(
              onTap: () {
                context.goNamed(AppRoute.settings.name);
              },
              title: Text(
                'S E T T I N G S',
                style: TextStyle(
                  color:
                      currentSection == Section.settings
                          ? Theme.of(context).colorScheme.secondary
                          : Colors.grey[600],
                ),
              ),
              leading: Icon(
                Icons.settings,
                color:
                    currentSection == Section.settings
                        ? Theme.of(context).colorScheme.secondary
                        : Colors.grey[600],
              ),
            ),
            const Spacer(),
            ListTile(
              onTap: () async {
                ref.watch(authControllerProvider.notifier).signOut();
              },
              title: const Text('L O G O U T'),
              leading: Icon(Icons.logout, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
