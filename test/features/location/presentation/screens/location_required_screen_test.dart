import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/location/domain/entities/permission_status_entity.dart';
import 'package:ride_together/features/location/presentation/screens/location_required_screen.dart';

void main() {
  group('LocationRequiredScreen', () {
    testWidgets('renders location required info for denied status', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LocationRequiredScreen(
              status: PermissionStatusEntity.denied,
            ),
          ),
        ),
      );

      expect(find.text('Location access needed'), findsOneWidget);
      expect(find.text('Enable Location'), findsOneWidget);
      expect(find.byIcon(Icons.location_on), findsOneWidget);
    });

    testWidgets('renders open settings button for permanentlyDenied status', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LocationRequiredScreen(
              status: PermissionStatusEntity.permanentlyDenied,
            ),
          ),
        ),
      );

      expect(find.text('Location access needed'), findsOneWidget);
      expect(find.text('Open Settings'), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });
  });
}
