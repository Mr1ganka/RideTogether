import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ride_together/core/theme/app_colors.dart';
import 'package:ride_together/core/theme/app_radius.dart';
import 'package:ride_together/core/theme/app_spacing.dart';
import 'package:ride_together/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:ride_together/features/ride/domain/entities/ride_status.dart';
import 'package:ride_together/features/ride/domain/entities/rider_role.dart';
import 'package:ride_together/features/ride/presentation/providers/ride_controller_provider.dart';
import 'package:ride_together/features/ride/presentation/providers/ride_repository_provider.dart';

class ActiveRidePanel extends ConsumerStatefulWidget {
  const ActiveRidePanel({super.key});

  @override
  ConsumerState<ActiveRidePanel> createState() => _ActiveRidePanelState();
}

class _ActiveRidePanelState extends ConsumerState<ActiveRidePanel> {
  bool _isExpanded = false;

  void _copyJoinCode(String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Join code "$code" copied to clipboard!'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Color _getStatusColor(RideStatus status, ThemeData theme) {
    switch (status) {
      case RideStatus.planned:
      case RideStatus.recruiting:
        return theme.colorScheme.primary;
      case RideStatus.active:
        return AppColors.success;
      case RideStatus.paused:
        return AppColors.warning;
      case RideStatus.completed:
      case RideStatus.cancelled:
        return theme.colorScheme.outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rideAsync = ref.watch(activeRideProvider);
    final currentUser = ref.watch(authStateProvider).value;

    return rideAsync.when(
      data: (ride) {
        if (ride == null) return const SizedBox.shrink();

        final isLeader =
            currentUser != null && ride.leader.rider.id == currentUser.id;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header row
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _getStatusColor(ride.status, theme),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ride.name,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            ride.status.name.toUpperCase(),
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: _getStatusColor(ride.status, theme),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Copy Join Code Pill
                    InkWell(
                      onTap: () => _copyJoinCode(ride.joinCode),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xs,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              ride.joinCode,
                              style: theme.textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onPrimaryContainer,
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.copy,
                              size: 14,
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        _isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                      ),
                      onPressed: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                    ),
                  ],
                ),

                if (_isExpanded) ...[
                  const Divider(height: AppSpacing.md),
                  if (ride.description != null &&
                      ride.description!.isNotEmpty) ...[
                    Text(
                      ride.description!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                  ],

                  // Member list
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Riders (${ride.members.length})',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  ...ride.members.map((member) {
                    final isMemberLeader = member.role == RiderRole.leader;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundColor:
                                theme.colorScheme.secondaryContainer,
                            child: Text(
                              member.rider.displayName.isNotEmpty
                                  ? member.rider.displayName[0].toUpperCase()
                                  : 'R',
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Expanded(
                            child: Text(
                              member.rider.displayName,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                          if (isMemberLeader)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.tertiaryContainer,
                                borderRadius:
                                    BorderRadius.circular(AppRadius.sm),
                              ),
                              child: Text(
                                'LEADER',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.onTertiaryContainer,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                ],

                const SizedBox(height: AppSpacing.sm),

                // Action buttons based on Role & Ride Status
                Row(
                  children: [
                    if (isLeader) ...[
                      if (ride.status == RideStatus.planned ||
                          ride.status == RideStatus.recruiting)
                        Expanded(
                          child: FilledButton.icon(
                            icon: const Icon(Icons.play_arrow, size: 18),
                            label: const Text('Start Ride'),
                            onPressed: () {
                              ref
                                  .read(rideControllerProvider.notifier)
                                  .updateRideStatus(
                                    rideId: ride.id,
                                    status: RideStatus.active,
                                  );
                            },
                          ),
                        )
                      else if (ride.status == RideStatus.active)
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.pause, size: 18),
                            label: const Text('Pause'),
                            onPressed: () {
                              ref
                                  .read(rideControllerProvider.notifier)
                                  .updateRideStatus(
                                    rideId: ride.id,
                                    status: RideStatus.paused,
                                  );
                            },
                          ),
                        )
                      else if (ride.status == RideStatus.paused)
                        Expanded(
                          child: FilledButton.icon(
                            icon: const Icon(Icons.play_arrow, size: 18),
                            label: const Text('Resume'),
                            onPressed: () {
                              ref
                                  .read(rideControllerProvider.notifier)
                                  .updateRideStatus(
                                    rideId: ride.id,
                                    status: RideStatus.active,
                                  );
                            },
                          ),
                        ),
                      const SizedBox(width: AppSpacing.xs),
                      IconButton.filledTonal(
                        icon: Icon(
                          Icons.flag,
                          color: theme.colorScheme.primary,
                        ),
                        tooltip: 'Complete Ride',
                        onPressed: () {
                          ref
                              .read(rideControllerProvider.notifier)
                              .updateRideStatus(
                                rideId: ride.id,
                                status: RideStatus.completed,
                              );
                        },
                      ),
                    ],
                    const SizedBox(width: AppSpacing.xs),
                    IconButton.outlined(
                      icon: Icon(
                        Icons.exit_to_app,
                        color: theme.colorScheme.error,
                      ),
                      tooltip: 'Leave Ride',
                      onPressed: () {
                        ref
                            .read(rideControllerProvider.notifier)
                            .leaveRide(ride.id);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}
