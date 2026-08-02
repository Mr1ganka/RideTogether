import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider tracking the vertical offset consumed by the top banner (e.g. NotchUpdateBanner).
/// Allows stacked notifications below it (like ActiveRidePanel) to smoothly animate up and down.
final topBannerOffsetProvider = StateProvider<double>((ref) => 0.0);
