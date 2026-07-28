import 'package:flutter/material.dart';
import 'package:ride_together/core/theme/app_radius.dart';

class JoinRidePill extends StatelessWidget {
  const JoinRidePill({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenW = MediaQuery.of(context).size.width;
    final padH = screenW * 0.044;
    final padV = screenW * 0.022;
    final iconSize = screenW * 0.055;
    final pillShadowBlur = screenW * 0.022;
    final pillShadowOffset = screenW * 0.011;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: padH, vertical: padV),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withValues(alpha: 0.4),
              blurRadius: pillShadowBlur,
              offset: Offset(0, pillShadowOffset),
            ),
          ],
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.group_add_outlined, color: theme.colorScheme.onPrimary, size: iconSize),
              SizedBox(width: screenW * 0.022),
              Text(
                'Ride',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}