import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/app/router/router_refresh_notifier.dart';

void main() {
  test('notifies listeners when refresh is called', () {
    final notifier = RouterRefreshNotifier();
    var notifications = 0;
    notifier.addListener(() => notifications++);

    notifier.refresh();

    expect(notifications, 1);

    notifier.dispose();
  });
}
