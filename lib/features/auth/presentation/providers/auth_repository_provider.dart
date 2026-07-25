import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_together/features/auth/data/repositories/firebase_auth_repository.dart';

import '../../domain/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return FirebaseAuthRepository();
});
