import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/startup/presentation/providers/startup_provider.dart';


final appLifecycleProvider =
    Provider<AppLifecycleObserver>((ref) {

  final observer =
      AppLifecycleObserver(ref);

  WidgetsBinding.instance.addObserver(observer);


  ref.onDispose(() {
    WidgetsBinding.instance.removeObserver(observer);
  });


  return observer;
});


class AppLifecycleObserver
    extends WidgetsBindingObserver {

  final Ref ref;

  AppLifecycleState? _previousState;


  AppLifecycleObserver(this.ref);


  @override
  void didChangeAppLifecycleState(
      AppLifecycleState state) {

    if (_previousState ==
            AppLifecycleState.paused &&
        state ==
            AppLifecycleState.resumed) {

      ref.invalidate(startupProvider);
    }


    _previousState = state;
  }
}
