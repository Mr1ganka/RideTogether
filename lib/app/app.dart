import 'package:flutter/material.dart';

class RideTogetherApp extends StatelessWidget {
  const RideTogetherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RideTogether',
      debugShowCheckedModeBanner: false,

      themeMode: ThemeMode.dark,

      theme: ThemeData.dark(),

      home: const Scaffold(
        body: Center(
          child: Text(
            'RideTogether',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}