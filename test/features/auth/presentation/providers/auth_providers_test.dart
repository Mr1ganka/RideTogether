import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/auth/domain/entities/app_user.dart';
import 'package:ride_together/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:ride_together/features/auth/presentation/providers/auth_state_provider.dart';
import '../../../../helpers/fake_auth_repository.dart';

void main() {
  group('Auth Providers', () {
    test('authRepositoryProvider can be overridden for dependency injection', () {
      final fakeRepo = FakeAuthRepository();
      final container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );
      addTearDown(container.dispose);

      final repository = container.read(authRepositoryProvider);
      expect(repository, equals(fakeRepo));
    });

    test('authStateProvider streams user authentication updates', () async {
      final fakeRepo = FakeAuthRepository(
        initialUser: const AppUser(id: 'user-1', email: 'test@example.com'),
      );

      final container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );
      addTearDown(container.dispose);

      final user = await container.read(authStateProvider.future);
      expect(user?.id, 'user-1');
      expect(user?.email, 'test@example.com');
    });
  });
}
