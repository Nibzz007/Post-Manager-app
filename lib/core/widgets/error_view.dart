import 'package:flutter/material.dart';
import 'package:post_manager_app/core/theme/theme.dart';

/// Global error state widget. Use on any screen when a request fails and the user can retry.
class ErrorView extends StatelessWidget {
  final String message;
  final String? title;
  final VoidCallback onRetry;
  final String retryLabel;

  const ErrorView({
    super.key,
    required this.message,
    required this.onRetry,
    this.title,
    this.retryLabel = 'Try again',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizing.space2xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: AppSizing.iconXl,
              color: colorScheme.error.withOpacity(0.8),
            ),
            const SizedBox(height: AppSizing.spaceXl),
            Text(
              title ?? 'Something went wrong',
              style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizing.spaceSm),
            Text(
              message,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: AppSizing.spaceXl),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded, size: AppSizing.iconSm),
              label: Text(retryLabel),
            ),
          ],
        ),
      ),
    );
  }
}
