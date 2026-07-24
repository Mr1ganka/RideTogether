import 'package:flutter/material.dart';

class NavHandle extends StatelessWidget {
  const NavHandle({required this.barVisible, required this.onTap, super.key});

  final bool barVisible;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenW = MediaQuery.of(context).size.width;

    final handleWidth = screenW * 0.22;
    final handleHeight = screenW * 0.08;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(handleHeight * 0.6),
          topRight: Radius.circular(handleHeight * 0.6),
        ),
        child: Ink(
          width: handleWidth,
          height: handleHeight,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withValues(alpha: 0.94),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(handleHeight * 0.6),
              topRight: Radius.circular(handleHeight * 0.6),
            ),
            boxShadow: null,
          ),
          child: Center(
            child: Icon(
              barVisible ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
