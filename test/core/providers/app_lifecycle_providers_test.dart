import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ride_together/core/providers/app_lifecycle_providers.dart';
import 'package:ride_together/features/startup/presentation/providers/startup_provider.dart';

class MockRef extends Mock implements Ref {}

void main() {
  test(
    'AppLifecycleObserver invalidates startupProvider on resume from paused state',
    () {
      final ref = MockRef();
      final observer = AppLifecycleObserver(ref);

      // Initially resumed
      observer.didChangeAppLifecycleState(AppLifecycleState.resumed);

      // Pause app
      observer.didChangeAppLifecycleState(AppLifecycleState.paused);
      verifyNever(() => ref.invalidate(startupProvider));

      // Resume app from paused state
      observer.didChangeAppLifecycleState(AppLifecycleState.resumed);

      verify(() => ref.invalidate(startupProvider)).called(1);
    },
  );
}
