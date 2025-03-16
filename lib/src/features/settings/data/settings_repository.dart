import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_repository.g.dart';

class SettingsRepository {
  static const String _boxName = 'settings';

  Future<Box> _openBox() async {
    return await Hive.openBox(_boxName);
  }

  Future<ThemeMode> themeMode() async {
    final box = await _openBox();
    final isDarkMode = box.get('isDarkMode', defaultValue: true) as bool;
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> toggleThemeMode(bool isDarkMode) async {
    final box = await _openBox();
    await box.put('isDarkMode', isDarkMode);
  }
}

@riverpod
SettingsRepository settingsRepository(Ref ref) {
  return SettingsRepository();
}
