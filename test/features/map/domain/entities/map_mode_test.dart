import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/map/domain/entities/map_mode.dart';

void main() {
  group('MapMode', () {
    test('contains all expected map modes', () {
      expect(
        MapMode.values,
        containsAll([
          MapMode.idle,
          MapMode.searchingRide,
          MapMode.activeRide,
          MapMode.navigation,
          MapMode.completedRide,
        ]),
      );
    });
  });
}
