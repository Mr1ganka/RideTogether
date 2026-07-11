import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/app_routes.dart';

class SplashScreen extends StatefulWidget{
  
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

    @override
    void initState() {
      super.initState();
      _initializeApp();
    }

    Future<void> _initializeApp() async{
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;
      context.go(AppRoutes.login);
    }
  

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: Text(
            'RideTogether',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
  }
}