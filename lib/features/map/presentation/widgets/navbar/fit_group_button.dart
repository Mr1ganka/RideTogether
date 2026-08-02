import 'package:flutter/material.dart';

class FitGroupButton extends StatelessWidget {
  const FitGroupButton({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenW = MediaQuery.of(context).size.width;
    final btnSize = screenW * 0.12;

    return Container(
      width: btnSize,
      height: btnSize,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.92),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          Icons.groups,
          color: theme.colorScheme.primary,
          size: btnSize * 0.5,
        ),
        onPressed: onTap,
        tooltip: 'Show All Riders',
        padding: EdgeInsets.zero,
      ),
    );
  }
}
