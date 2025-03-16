import 'package:chat_app/src/features/settings/data/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_mode_controller.g.dart';

@riverpod
class ThemeModeController extends _$ThemeModeController {
  @override
  Future<ThemeMode> build() async {
    return await ref.read(settingsRepositoryProvider).themeMode();
  }

  Future<void> toggleTheme() async {
    final currentMode = await future;
    final isDarkMode = currentMode == ThemeMode.dark;
    await ref.read(settingsRepositoryProvider).toggleThemeMode(!isDarkMode);
    state = AsyncData(isDarkMode ? ThemeMode.light : ThemeMode.dark);
  }
}
