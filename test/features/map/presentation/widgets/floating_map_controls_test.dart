import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:ride_together/features/map/domain/entities/map_mode.dart';
import 'package:ride_together/features/map/presentation/providers/map_mode_provider.dart';
import 'package:ride_together/features/map/presentation/widgets/floating_map_controls.dart';
import 'package:ride_together/features/map/presentation/widgets/navbar/bottom_nav_bar.dart';
import 'package:ride_together/features/map/presentation/widgets/navbar/join_ride_pill.dart';
import 'package:ride_together/features/map/presentation/widgets/navbar/nav_handle.dart';
import 'package:ride_together/features/map/presentation/widgets/navbar/nav_icon_button.dart';
import 'package:ride_together/features/map/presentation/widgets/navbar/recenter_button.dart';

import '../../../../helpers/fake_auth_repository.dart';

void main() {
  late MapController mapController;

  setUp(() {
    mapController = MapController();
  });

  group('FloatingMapControls & Navbar components', () {
    testWidgets('renders all floating controls in idle mode', (tester) async {
      final fakeAuth = FakeAuthRepository();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authRepositoryProvider.overrideWithValue(fakeAuth),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: FloatingMapControls(mapController: mapController),
            ),
          ),
        ),
      );

      expect(find.byType(RecenterButton), findsOneWidget);
      expect(find.byType(BottomNavBar), findsOneWidget);
      expect(find.byType(NavHandle), findsOneWidget);
      expect(find.byType(JoinRidePill), findsOneWidget);
      expect(find.byType(NavIconButton), findsNWidgets(4));
    });

    testWidgets('hides all controls in navigation map mode', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            mapModeProvider.overrideWith((ref) => MapMode.navigation),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: FloatingMapControls(mapController: mapController),
            ),
          ),
        ),
      );

      expect(find.byType(RecenterButton), findsNothing);
      expect(find.byType(BottomNavBar), findsNothing);
    });

    testWidgets('NavHandle toggles bar visibility on tap', (tester) async {
      final fakeAuth = FakeAuthRepository();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authRepositoryProvider.overrideWithValue(fakeAuth),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: FloatingMapControls(mapController: mapController),
            ),
          ),
        ),
      );

      expect(find.byType(NavHandle), findsOneWidget);
      await tester.tap(find.byType(NavHandle), warnIfMissed: false);
      await tester.pump(const Duration(milliseconds: 300));
    });
  });
}
