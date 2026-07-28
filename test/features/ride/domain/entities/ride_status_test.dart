import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/features/ride/domain/entities/ride_status.dart';

void main() {
  group('RideStatus', () {
    test('isJoinable returns true for planned, recruiting, active, paused', () {
      expect(RideStatus.planned.isJoinable, isTrue);
      expect(RideStatus.recruiting.isJoinable, isTrue);
      expect(RideStatus.active.isJoinable, isTrue);
      expect(RideStatus.paused.isJoinable, isTrue);
    });

    test('isJoinable returns false for completed and cancelled', () {
      expect(RideStatus.completed.isJoinable, isFalse);
      expect(RideStatus.cancelled.isJoinable, isFalse);
    });
  });
}
