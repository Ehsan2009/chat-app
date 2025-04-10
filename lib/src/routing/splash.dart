import 'package:chat_app/src/features/authentication/data/auth_repository.dart';
import 'package:chat_app/src/features/authentication/presentation/auth_screen.dart';
import 'package:chat_app/src/features/chat/presentation/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateAsync = ref.watch(authStateChangesProvider);

    return authStateAsync.when(
      data: (user) {
        if (user == null) AuthScreen();

        return ChatScreen();
      },
      error: (error, _) {
        return Scaffold(body: Center(child: Text(error.toString())));
      },
      loading: () {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );

    // StreamBuilder(
    //   stream: authRepository.authStateChanges(),
    //   builder: (ctx, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Scaffold(
    //         body: Center(
    //           child: CircularProgressIndicator(),
    //         ),
    //       );
    //     }

    //     if (snapshot.hasData) {
    //       return const PostsScreen();
    //     }

    //     return const AuthScreen();
    //   },
    // );
  }
}
