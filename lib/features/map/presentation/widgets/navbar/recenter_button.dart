import 'package:flutter/material.dart';

class RecenterButton extends StatelessWidget {
  const RecenterButton({
    required this.onTap,
    super.key,
  });

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
        boxShadow: null,
      ),
      child: IconButton(
        icon: Icon(
          Icons.my_location,
          color: theme.colorScheme.primary,
          size: btnSize * 0.5,
        ),
        onPressed: onTap,
        padding: EdgeInsets.zero,
      ),
    );
  }
}