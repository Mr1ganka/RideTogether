import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/startup/presentation/screens/splash_screen.dart';

void main() {
  testWidgets('SplashScreen renders app title', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SplashScreen()));

    expect(find.text('RideTogether'), findsOneWidget);
  });
}
