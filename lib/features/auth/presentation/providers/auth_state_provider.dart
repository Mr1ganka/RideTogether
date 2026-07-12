import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_together/features/auth/presentation/providers/auth_repository_provider.dart';
import '../../domain/entities/app_user.dart';

final authStateProvider =
    StreamProvider<AppUser?>((ref) {
  final repository = ref.watch(authRepositoryProvider);

  return repository.authStateChanges();
});