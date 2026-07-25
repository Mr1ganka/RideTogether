import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/auth/domain/entities/app_user.dart';

void main() {
  group('AppUser', () {
    test('retains all rider profile fields', () {
      const user = AppUser(
        id: 'rider-1',
        email: 'rider@example.com',
        displayName: 'Alex Rider',
        photoUrl: 'https://example.com/avatar.png',
      );

      expect(user.id, 'rider-1');
      expect(user.email, 'rider@example.com');
      expect(user.displayName, 'Alex Rider');
      expect(user.photoUrl, 'https://example.com/avatar.png');
    });

    test('supports nullable optional parameters', () {
      const user = AppUser(id: 'rider-2');

      expect(user.id, 'rider-2');
      expect(user.email, isNull);
      expect(user.displayName, isNull);
      expect(user.photoUrl, isNull);
    });
  });
}
