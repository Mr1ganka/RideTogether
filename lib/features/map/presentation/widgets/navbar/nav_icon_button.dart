import 'package:flutter/material.dart';
import 'package:ride_together/core/theme/app_radius.dart';

class NavIconButton extends StatelessWidget {
  const NavIconButton({
    required this.icon,
    required this.label,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenW = MediaQuery.of(context).size.width;
    final iconSize = screenW * 0.055; // Reduced from 0.06
    final padV = screenW * 0.014; // Reduced from 0.016
    final padH = screenW * 0.024; // Reduced from 0.028
    final gap = screenW * 0.004; // Reduced from 0.005
    final labelSize = screenW * 0.024; // Reduced from 0.028

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: padV, horizontal: padH),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: theme.colorScheme.primary, size: iconSize),
            SizedBox(height: gap),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: labelSize,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
