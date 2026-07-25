import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/map/presentation/widgets/app_map.dart';

void main() {
  testWidgets('AppMap renders FlutterMap', (tester) async {
    final mapController = MapController();

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(body: AppMap(mapController: mapController)),
        ),
      ),
    );

    expect(find.byType(AppMap), findsOneWidget);
    expect(find.byType(FlutterMap), findsOneWidget);
  });
}
