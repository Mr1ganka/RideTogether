import '../entities/app_user.dart';

abstract class AuthRepository {
  Stream<AppUser?> authStateChanges();

  Future<AppUser?> signInWithGoogle();

  Future<void> signOut();

  AppUser? get currentUser;
}