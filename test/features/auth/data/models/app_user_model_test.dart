import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ride_together/features/auth/data/models/app_user_model.dart';
import 'package:ride_together/features/auth/domain/entities/app_user.dart';

class MockUser extends Mock implements User {}

void main() {
  group('AppUserModel', () {
    test('creates AppUserModel from Firebase User', () {
      final mockUser = MockUser();
      when(() => mockUser.uid).thenReturn('uid-123');
      when(() => mockUser.email).thenReturn('user@example.com');
      when(() => mockUser.displayName).thenReturn('John Doe');
      when(() => mockUser.photoURL).thenReturn('https://photo.url');

      final model = AppUserModel.fromFirebaseUser(mockUser);

      expect(model, isA<AppUser>());
      expect(model.id, 'uid-123');
      expect(model.email, 'user@example.com');
      expect(model.displayName, 'John Doe');
      expect(model.photoUrl, 'https://photo.url');
    });

    test('creates AppUserModel with nullable fields from Firebase User', () {
      final mockUser = MockUser();
      when(() => mockUser.uid).thenReturn('uid-456');
      when(() => mockUser.email).thenReturn(null);
      when(() => mockUser.displayName).thenReturn(null);
      when(() => mockUser.photoURL).thenReturn(null);

      final model = AppUserModel.fromFirebaseUser(mockUser);

      expect(model.id, 'uid-456');
      expect(model.email, isNull);
      expect(model.displayName, isNull);
      expect(model.photoUrl, isNull);
    });
  });
}
