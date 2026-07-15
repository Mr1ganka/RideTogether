import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_repository_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                const Icon(Icons.motorcycle, size: 80),

                const SizedBox(height: 24),

                Text(
                  'RideTogether',

                  style: Theme.of(context).textTheme.headlineMedium,
                ),

                const SizedBox(height: 12),

                Text(
                  'Ride together.\nStay connected.\nRide safer.',

                  textAlign: TextAlign.center,

                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                const SizedBox(height: 48),

                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 320),

                  child: ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        final repository = ref.read(authRepositoryProvider);

                        await repository.signInWithGoogle();
                      } catch (e) {
                        if (!context.mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Sign in failed. Please try again.'),
                          ),
                        );
                      }
                    },

                    icon: const Icon(Icons.login),

                    label: const Text('Continue with Google'),
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  'By continuing, you agree to our Terms of Service and Privacy Policy.',

                  textAlign: TextAlign.center,

                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
