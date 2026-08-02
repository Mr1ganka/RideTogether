import 'package:flutter_riverpod/flutter_riverpod.dart';

enum BackgroundConsentState { unasked, accepted, declined }

class BackgroundConsentNotifier extends StateNotifier<BackgroundConsentState> {
  BackgroundConsentNotifier() : super(BackgroundConsentState.unasked);

  void accept() {
    state = BackgroundConsentState.accepted;
  }

  void decline() {
    state = BackgroundConsentState.declined;
  }

  void reset() {
    state = BackgroundConsentState.unasked;
  }
}

final backgroundConsentProvider =
    StateNotifierProvider<BackgroundConsentNotifier, BackgroundConsentState>(
  (ref) => BackgroundConsentNotifier(),
);
