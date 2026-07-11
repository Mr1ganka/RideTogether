import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ride_together/app/router/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: () {
          context.go(AppRoutes.home);
        },
        child: const Text('Login'),
        ),
      ),
    );
  }
}