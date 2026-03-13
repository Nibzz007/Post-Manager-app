import 'package:flutter/material.dart';

import '../theme/theme.dart';

/// Common loading indicator. Use for full-screen or inline loading states.
class AppLoader extends StatelessWidget {
  final String? message;
  final double indicatorSize;
  final double strokeWidth;

  const AppLoader({
    super.key,
    this.message,
    this.indicatorSize = 32,
    this.strokeWidth = 2.5,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: indicatorSize,
            height: indicatorSize,
            child: CircularProgressIndicator(
              strokeWidth: strokeWidth,
              color: colorScheme.primary,
            ),
          ),
          if (message != null && message!.isNotEmpty) ...[
            SizedBox(height: AppSizing.spaceLg),
            Text(
              message!,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
