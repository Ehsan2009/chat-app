import 'package:chat_app/src/features/settings/data/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

void main() {
  late MockHiveInterface mockHiveInterface;
  late SettingsRepository settingsRepository;
  late Box mockBox;

  setUp(() async {
    mockHiveInterface = MockHiveInterface();
    mockBox = MockBox();

    when(
      () => mockHiveInterface.openBox('settings'),
    ).thenAnswer((_) async => mockBox);

    settingsRepository = SettingsRepository(mockHiveInterface);
  });

  group('SettingsRepository', () {
    test(
      '''
given isDarkMode is true 
when calling settingsRepository.themeMode()
then it returns themeMode.dart
''',
      () async {
        when(
          () => mockBox.get('isDarkMode', defaultValue: true),
        ).thenReturn(true);

        final themeMode = settingsRepository.themeMode();

        expect(await themeMode, ThemeMode.dark);
        verify(() => mockBox.get('isDarkMode', defaultValue: true)).called(1);
      },
    );

    test(
      '''
given isDarkMode is false 
when calling settingsRepository.themeMode()
then it returns themeMode.light
''',
      () async {
        when(
          () => mockBox.get('isDarkMode', defaultValue: true),
        ).thenReturn(false);

        final themeMode = settingsRepository.themeMode();

        expect(await themeMode, ThemeMode.light);
        verify(() => mockBox.get('isDarkMode', defaultValue: true)).called(1);
      },
    );

    test(
      '''
given isDarkMode is true 
when calling settingsRepository.toggleThemeMode()
then it returns themeMode.light
''',
      () async {
        when(
          () => mockBox.get('isDarkMode', defaultValue: true),
        ).thenReturn(false);

        when(
          () => mockBox.put('isDarkMode', true),
        ).thenAnswer((_) async => Future.value());

        await settingsRepository.toggleThemeMode(true);

        final themeMode = settingsRepository.themeMode();

        expect(await themeMode, ThemeMode.light);
        verify(() => mockBox.put('isDarkMode', true)).called(1);
      },
    );
  });
}
