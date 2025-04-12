import 'package:chat_app/src/features/authentication/application/auth_service.dart';
import 'package:chat_app/src/features/authentication/data/auth_repository.dart';
import 'package:chat_app/src/features/authentication/domain/app_user.dart';
import 'package:chat_app/src/features/authentication/presentation/auth_screen.dart';
import 'package:chat_app/src/features/chat/data/chat_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

void main() {
  late Ref mockRef;
  late MockAuthRepository mockAuthRepository;
  late MockChatRepository mockChatRepository;
  late AuthService authService;

  setUp(() {
    mockRef = MockRef();
    mockAuthRepository = MockAuthRepository();
    mockChatRepository = MockChatRepository();
    authService = AuthService(mockRef);

    when(
      () => mockRef.read(authRepositoryProvider),
    ).thenReturn(mockAuthRepository);
    when(
      () => mockRef.read(chatRepositoryProvider),
    ).thenReturn(mockChatRepository);
  });

  group('Auth Service', () {
    final email = 'test@example.com';
    final id = '123';
    final password = '123456';
    final signInFormType = EmailPasswordSignInFormType.signIn;
    final registerFormType = EmailPasswordSignInFormType.register;

    test(
      ('authenticate with signIn calls signInWithEmailAndPassword'),
      () async {
        when(
          () => mockAuthRepository.signInWithEmailAndPassword(email, password),
        ).thenAnswer((_) async => {});

        await authService.authenticate(email, password, signInFormType);

        verify(
          () => mockAuthRepository.signInWithEmailAndPassword(email, password),
        ).called(1);
        verifyNever(
          () => mockAuthRepository.createUserWithEmailAndPassword(any(), any()),
        );
        verifyNever(() => mockChatRepository.storeUserEmail(any(), any()));
      },
    );

    test(
      ('authenticate with register calls createUser and storeUserEmail'),
      () async {
        when(
          () => mockAuthRepository.createUserWithEmailAndPassword(
            email,
            password,
          ),
        ).thenAnswer((_) async => {});

        when(
          () => mockAuthRepository.currentUser,
        ).thenReturn(AppUser(id: id, email: email));

        when(
          () => mockChatRepository.storeUserEmail(id, email),
        ).thenAnswer((_) async => {});

        await authService.authenticate(email, password, registerFormType);

        verify(
          () => mockAuthRepository.createUserWithEmailAndPassword(
            email,
            password,
          ),
        ).called(1);
        verify(() => mockChatRepository.storeUserEmail(id, email)).called(1);
      },
    );
  });
}
