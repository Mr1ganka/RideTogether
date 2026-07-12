import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features/auth/presentation/providers/auth_repository_provider.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'RideTogether',
        ),

        actions: [

          IconButton(
            icon: const Icon(
              Icons.logout,
            ),

            onPressed: () async {

              final repository =
                  ref.read(authRepositoryProvider);


              await repository.signOut();

            },
          ),

        ],
      ),


      body: const Center(
        child: Text(
          'Home Screen',
        ),
      ),
    );
  }
}