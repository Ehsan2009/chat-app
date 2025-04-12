import 'package:chat_app/src/features/authentication/data/auth_repository.dart';
import 'package:chat_app/src/features/authentication/domain/app_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late AuthRepository authRepository;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    authRepository = AuthRepository(mockFirebaseAuth);
  });

  group('Auth Repository', () {
    const email = 'test@example.com';
    const password = 'password123';

    test('signInWithEmailAndPassword calls FirebaseAuth method', () async {
      when(
        () => mockFirebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        ),
      ).thenAnswer((_) async => MockUserCredential());

      await authRepository.signInWithEmailAndPassword(email, password);

      verify(
        () => mockFirebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        ),
      ).called(1);
    });

    test('createUserWithEmailAndPassword calls FirebaseAuth method', () async {
      when(
        () => mockFirebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        ),
      ).thenAnswer((_) async => MockUserCredential());

      await authRepository.createUserWithEmailAndPassword(email, password);

      verify(
        () => mockFirebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        ),
      ).called(1);
    });

    test('Test signOut calles FirebaseAuth signOut', () async {
      when(() => mockFirebaseAuth.signOut()).thenAnswer((_) async => {});

      await authRepository.signOut();

      verify(() => mockFirebaseAuth.signOut()).called(1);
    });

    test(
      'watchAuthStateChanges emits an AppUser when user is authenticated',
      () {
        final mockUser = MockUser();
        when(() => mockUser.uid).thenReturn('123');
        when(() => mockUser.email).thenReturn('test@example.com');

        when(
          () => mockFirebaseAuth.authStateChanges(),
        ).thenAnswer((_) => Stream.value(mockUser));

        final stream = authRepository.watchAuthStateChanges();

        expectLater(
          stream,
          emits(
            predicate<AppUser?>(
              (user) => user?.id == '123' && user?.email == 'test@example.com',
            ),
          ),
        );
      },
    );

    test('currentUser getter, returns an AppUser if the user is signed in', () {
      final mockUser = MockUser();
      when(() => mockUser.uid).thenReturn('123');
      when(() => mockUser.email).thenReturn('test@example.com');
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);

      final user = authRepository.currentUser;

      expect(user, isA<AppUser>());
      expect(user?.id, '123');
      expect(user?.email, 'test@example.com');
    });

    test('currentUser returns null if no user is signed in', () {
      when(() => mockFirebaseAuth.currentUser).thenReturn(null);

      final user = authRepository.currentUser;

      expect(user, isNull);
    });


  });
}
