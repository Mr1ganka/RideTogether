import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:ride_together/app/router/router_refresh_notifier.dart';

void main() {
  test('notifies listeners for each auth-state update', () async {
    final controller = StreamController<Object?>();
    final notifier = RouterRefreshNotifier(controller.stream);
    var notifications = 0;
    notifier.addListener(() => notifications++);

    controller.add(Object());
    await Future<void>.delayed(Duration.zero);

    expect(notifications, 1);

    notifier.dispose();
    await controller.close();
  });
}
