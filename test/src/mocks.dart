import 'package:chat_app/src/features/authentication/application/auth_service.dart';
import 'package:chat_app/src/features/authentication/data/auth_repository.dart';
import 'package:chat_app/src/features/authentication/presentation/auth_controller.dart';
import 'package:chat_app/src/features/chat/data/chat_repository.dart';
import 'package:chat_app/src/features/settings/data/settings_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockRef extends Mock implements Ref {}

class MockChatRepository extends Mock implements ChatRepository {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

class MockUserCredential extends Mock implements UserCredential {}

class MockAuthService extends Mock implements AuthService {}

class MockAuthController extends Mock implements AuthController {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockBox extends Mock implements Box {}

class MockHiveInterface extends Mock implements HiveInterface {}

class MockSettingsRepository extends Mock implements SettingsRepository {}