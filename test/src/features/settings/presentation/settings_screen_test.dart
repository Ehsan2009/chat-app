import 'package:chat_app/src/features/settings/data/settings_repository.dart';
import 'package:chat_app/src/features/settings/presentation/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

void main() {
  late MockSettingsRepository mockSettingsRepository;

  setUp(() {
    mockSettingsRepository = MockSettingsRepository();
  });

  group('SettingsScreen', () {
    testWidgets(
      'tapping switch button calls toggleTheme() on settings repository',
      (tester) async {
        when(
          () => mockSettingsRepository.themeMode(),
        ).thenAnswer((_) async => ThemeMode.dark);

        when(
          () => mockSettingsRepository.toggleThemeMode(any()),
        ).thenAnswer((_) async => Future.value());

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              settingsRepositoryProvider.overrideWithValue(
                mockSettingsRepository,
              ),
            ],
            child: MaterialApp(home: SettingsScreen()),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(Switch));
        await tester.pumpAndSettle();

        verify(() => mockSettingsRepository.toggleThemeMode(any())).called(1);
      },
    );
  });
}
