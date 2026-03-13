import 'package:flutter/material.dart';
import 'package:post_manager_app/core/theme/theme.dart';

/// Global empty state widget. Use on any screen when there is no data to show.
class EmptyState extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? icon;
  final VoidCallback? onAction;
  final String? actionLabel;

  const EmptyState({
    super.key,
    this.title = 'Nothing here',
    this.subtitle = 'Pull down to refresh or tap the button below.',
    this.icon,
    this.onAction,
    this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizing.space2xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.inbox_outlined,
              size: AppSizing.iconEmpty,
              color: colorScheme.primary.withValues(alpha: 0.4),
            ),
            const SizedBox(height: AppSizing.spaceXl),
            Text(
              title,
              style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizing.spaceSm),
            Text(
              subtitle,
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            if (onAction != null) ...[
              const SizedBox(height: AppSizing.spaceXl),
              FilledButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.refresh_rounded, size: AppSizing.iconSm),
                label: Text(actionLabel ?? 'Refresh'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
