import 'package:chat_app/src/features/settings/data/settings_repository.dart';
import 'package:chat_app/src/features/settings/presentation/theme_mode_controller.dart';
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

  group('ThemeModeController', () {
    test(
      '''
given settingsRepository
when reading themeModeController
then it returns a theme mode
''',
      () async {
        when(
          () => mockSettingsRepository.themeMode(),
        ).thenAnswer((_) async => ThemeMode.dark);

        final container = ProviderContainer(
          overrides: [
            settingsRepositoryProvider.overrideWithValue(
              mockSettingsRepository,
            ),
          ],
        );

        final themeMode = await container.read(
          themeModeControllerProvider.future,
        );

        expect(themeMode, ThemeMode.dark);
      },
    );

    test(
      '''
given mockSettingsRepository
when calling toggleTheme() on themeModeController
then toggleThemeMode in mockSettingsRepository should be called
''',
      () async {
        when(
          () => mockSettingsRepository.themeMode(),
        ).thenAnswer((_) async => ThemeMode.dark);

        when(
          () => mockSettingsRepository.toggleThemeMode(any()),
        ).thenAnswer((_) async => Future.value());

        final container = ProviderContainer(
          overrides: [
            settingsRepositoryProvider.overrideWithValue(
              mockSettingsRepository,
            ),
          ],
        );

        await container
            .read(themeModeControllerProvider.notifier)
            .toggleTheme();

        verify(() => mockSettingsRepository.toggleThemeMode(any())).called(1);
      },
    );
  });
}
