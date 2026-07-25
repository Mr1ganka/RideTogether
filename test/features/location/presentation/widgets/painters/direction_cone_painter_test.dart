import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/location/presentation/widgets/painters/direction_cone_painter.dart';

void main() {
  testWidgets('DirectionConePainterWidget renders CustomPaint', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: DirectionConePainterWidget(),
          ),
        ),
      ),
    );

    expect(find.byType(DirectionConePainterWidget), findsOneWidget);
    expect(find.byType(CustomPaint), findsWidgets);
  });

  test('DirectionConePainter shouldRepaint returns false', () {
    final painter = DirectionConePainter();
    expect(painter.shouldRepaint(DirectionConePainter()), isFalse);
  });
}
