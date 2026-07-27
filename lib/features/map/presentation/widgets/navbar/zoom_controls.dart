import 'package:flutter/material.dart';

class ZoomControls extends StatelessWidget {
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;

  const ZoomControls({
    super.key,
    required this.onZoomIn,
    required this.onZoomOut,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenW = MediaQuery.of(context).size.width;
    final btnWidth = screenW * 0.11;

    return Container(
      width: btnWidth,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              Icons.add_rounded,
              color: theme.colorScheme.primary,
              size: btnWidth * 0.55,
            ),
            onPressed: onZoomIn,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints.tightFor(width: btnWidth, height: btnWidth),
          ),
          Divider(
            height: 1,
            thickness: 0.8,
            indent: 6,
            endIndent: 6,
            color: theme.dividerColor.withValues(alpha: 0.2),
          ),
          IconButton(
            icon: Icon(
              Icons.remove_rounded,
              color: theme.colorScheme.primary,
              size: btnWidth * 0.55,
            ),
            onPressed: onZoomOut,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints.tightFor(width: btnWidth, height: btnWidth),
          ),
        ],
      ),
    );
  }
}
