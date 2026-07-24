import 'package:flutter/material.dart';
import 'package:ride_together/core/theme/app_radius.dart';

import 'nav_icon_button.dart';
import 'join_ride_pill.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    required this.onProfileTap,
    required this.onMyRidesTap,
    required this.onJoinRideTap,
    required this.onSettingsTap,
    required this.onLogoutTap,
    super.key,
  });

  final VoidCallback onProfileTap;
  final VoidCallback onMyRidesTap;
  final VoidCallback onJoinRideTap;
  final VoidCallback onSettingsTap;
  final VoidCallback onLogoutTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenW = MediaQuery.of(context).size.width;

    final barHeight = screenW * 0.17;

    return Container(
      height: barHeight,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: NavIconButton(
              icon: Icons.person_outlined,
              label: 'Profile',
              onTap: onProfileTap,
            ),
          ),

          Expanded(
            child: NavIconButton(
              icon: Icons.history_outlined,
              label: 'Rides',
              onTap: onMyRidesTap,
            ),
          ),

          Expanded(
            flex: 2,
            child: Center(child: JoinRidePill(onTap: onJoinRideTap)),
          ),

          Expanded(
            child: NavIconButton(
              icon: Icons.settings_outlined,
              label: 'Settings',
              onTap: onSettingsTap,
            ),
          ),

          Expanded(
            child: NavIconButton(
              icon: Icons.logout,
              label: 'Logout',
              onTap: onLogoutTap,
            ),
          ),
        ],
      ),
    );
  }
}
