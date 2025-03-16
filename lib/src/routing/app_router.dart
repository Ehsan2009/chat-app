import 'package:chat_app/src/features/authentication/data/auth_repository.dart';
import 'package:chat_app/src/features/authentication/presentation/auth_screen.dart';
import 'package:chat_app/src/features/chat/presentation/chat_screen.dart';
import 'package:chat_app/src/features/chat/presentation/widgets/chat_room/chat_room.dart';
import 'package:chat_app/src/features/settings/presentation/settings_screen.dart';
import 'package:chat_app/src/routing/go_router_refresh_stream.dart';
import 'package:chat_app/src/routing/not_found_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

enum AppRoute {
  auth,
  chat,
  chatRoom,
  settings,
}

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/auth',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = authRepository.currentUser != null;
      final path = state.uri.path;
      if (isLoggedIn) {
        if (path == '/auth') {
          return '/chat';
        }
      } else {
        if (path == '/chat' || path.startsWith('/chat-room') || path == '/settings') {
          return '/auth';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/auth',
        name: AppRoute.auth.name,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/chat',
        name: AppRoute.chat.name,
        builder: (context, state) => const ChatScreen(),
      ),
      GoRoute(
        path: '/chat-room/:userEmail',
        name: AppRoute.chatRoom.name,
        builder: (context, state) {
          final otherUserEmail = state.pathParameters['userEmail']!;
          return ChatRoom(currentContact: otherUserEmail);
        },
      ),
      GoRoute(
        path: '/settings',
        name: AppRoute.settings.name,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
