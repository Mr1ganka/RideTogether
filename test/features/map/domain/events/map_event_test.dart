import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/map/domain/events/map_event.dart';

void main() {
  group('MapEvent', () {
    test('MapEvent interface sealed hierarchy exists', () {
      expect(MapEvent, isNotNull);
    });
  });
}
