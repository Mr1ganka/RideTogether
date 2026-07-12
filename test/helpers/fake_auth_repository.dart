import 'dart:async';

import 'package:ride_together/features/auth/domain/entities/app_user.dart';
import 'package:ride_together/features/auth/domain/repositories/auth_repository.dart';

class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({AppUser? initialUser}) : _currentUser = initialUser;

  final StreamController<AppUser?> _authStateController =
      StreamController<AppUser?>.broadcast();
  AppUser? _currentUser;
  int signInCallCount = 0;
  int signOutCallCount = 0;

  @override
  Stream<AppUser?> authStateChanges() async* {
    yield _currentUser;
    yield* _authStateController.stream;
  }

  @override
  AppUser? get currentUser => _currentUser;

  @override
  Future<AppUser?> signInWithGoogle() async {
    signInCallCount++;
    return _currentUser;
  }

  @override
  Future<void> signOut() async {
    signOutCallCount++;
    _currentUser = null;
    _authStateController.add(null);
  }
}
