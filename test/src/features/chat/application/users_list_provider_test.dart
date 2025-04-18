import 'package:chat_app/src/features/authentication/data/auth_repository.dart';
import 'package:chat_app/src/features/authentication/domain/app_user.dart';
import 'package:chat_app/src/features/chat/application/users_list_provider.dart';
import 'package:chat_app/src/features/chat/data/chat_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

void main() {
  const testId = '123';
  const testEmail = 'test@example.com';
  const otherUserEmail = 'other@user.com';

  test('fetchUsers method should return all users email except current user', () async {
    final mockAuthRepository = MockAuthRepository();
    final mockChatRepository = MockChatRepository();

    when(
      () => mockAuthRepository.currentUser,
    ).thenReturn(AppUser(id: testId, email: testEmail));
    when(
      () => mockChatRepository.fetchUsersEmail(testEmail),
    ).thenAnswer((_) async => [otherUserEmail]);

    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockAuthRepository),
        chatRepositoryProvider.overrideWithValue(mockChatRepository),
      ],
    );

    final result = await container.read(fetchUsersProvider.future);

    expect(result, [otherUserEmail]);

    verify(() => mockAuthRepository.currentUser).called(1);
    verify(() => mockChatRepository.fetchUsersEmail(testEmail)).called(1);
  });
}
