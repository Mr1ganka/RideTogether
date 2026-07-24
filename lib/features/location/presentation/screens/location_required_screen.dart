import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../../domain/entities/permission_status_entity.dart';
import '../providers/location_permission_provider.dart';
import '../../../startup/presentation/providers/startup_provider.dart';

class LocationRequiredScreen extends ConsumerWidget {
  final PermissionStatusEntity status;

  const LocationRequiredScreen({super.key, required this.status});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final permissionState = ref.watch(locationPermissionProvider);

    final currentStatus = permissionState.valueOrNull ?? status;

    final notifier = ref.read(locationPermissionProvider.notifier);

    final shouldOpenSettings =
        currentStatus == PermissionStatusEntity.permanentlyDenied ||
        notifier.shouldOpenSettings;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 80,
                  color: theme.colorScheme.primary,
                ),

                const SizedBox(height: 24),

                Text(
                  'Location access needed',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineMedium,
                ),

                const SizedBox(height: 12),

                Text(
                  'RideTogether uses your location to show your position on the map and connect you with nearby riders.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge,
                ),

                const SizedBox(height: 48),

                ElevatedButton.icon(
                  onPressed: () async {
                    if (currentStatus ==
                        PermissionStatusEntity.permanentlyDenied) {
                      await Geolocator.openAppSettings();

                      return;
                    }

                    final result = await ref
                        .read(locationPermissionProvider.notifier)
                        .requestPermission();

                    if (result == PermissionStatusEntity.granted) {
                      ref.invalidate(startupProvider);
                    }
                  },

                  icon: Icon(
                    shouldOpenSettings ? Icons.settings : Icons.location_on,
                  ),

                  label: Text(
                    shouldOpenSettings ? 'Open Settings' : 'Enable Location',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
