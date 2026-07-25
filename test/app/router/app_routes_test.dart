import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/app/router/app_routes.dart';

void main() {
  group('AppRoutes', () {
    test('route path constants are correctly defined', () {
      expect(AppRoutes.splash, '/');
      expect(AppRoutes.login, '/login');
      expect(AppRoutes.home, '/home');
      expect(AppRoutes.locationRequired, '/location-required');
    });
  });
}
