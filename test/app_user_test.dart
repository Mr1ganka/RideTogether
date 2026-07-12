import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/auth/domain/entities/app_user.dart';

void main() {
  test('retains the rider profile fields', () {
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
}
