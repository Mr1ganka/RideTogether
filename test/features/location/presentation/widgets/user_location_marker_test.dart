import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/location/presentation/widgets/components/accuracy_circle.dart';
import 'package:ride_together/features/location/presentation/widgets/components/direction_indicator.dart';
import 'package:ride_together/features/location/presentation/widgets/components/location_dot.dart';
import 'package:ride_together/features/location/presentation/widgets/user_location_marker.dart';
import 'package:ride_together/features/map/domain/entities/geo_point.dart';
import 'package:ride_together/features/map/domain/entities/user_location_marker.dart' as map_entity;

void main() {
  group('UserLocationMarker components', () {
    testWidgets('AccuracyCircle renders animated opacity container', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AccuracyCircle(radius: 50.0),
          ),
        ),
      );

      expect(find.byType(AccuracyCircle), findsOneWidget);
    });

    testWidgets('LocationDot renders animated inner and outer dot', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LocationDot(),
          ),
        ),
      );

      expect(find.byType(LocationDot), findsOneWidget);
    });

    testWidgets('DirectionIndicator renders when heading is provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DirectionIndicator(heading: 180.0),
          ),
        ),
      );

      expect(find.byType(DirectionIndicator), findsOneWidget);
    });

    testWidgets('UserLocationMarker renders location dot and accuracy circle', (tester) async {
      final markerEntity = map_entity.UserLocationMarker(
        id: 'u-1',
        position: const GeoPoint(latitude: 10, longitude: 20),
        heading: 45.0,
        accuracy: 20.0,
        timestamp: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UserLocationMarker(marker: markerEntity),
          ),
        ),
      );

      expect(find.byType(UserLocationMarker), findsOneWidget);
      expect(find.byType(LocationDot), findsOneWidget);
      expect(find.byType(DirectionIndicator), findsOneWidget);
      expect(find.byType(AccuracyCircle), findsOneWidget);
    });
  });
}
