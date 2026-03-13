import 'package:flutter/material.dart';
import 'package:post_manager_app/core/theme/theme.dart';
import 'package:post_manager_app/domain/entities/movie_entity.dart';

/// Shows a dialog asking the user to sign in to add a movie to favorites.
/// Returns true if user tapped "Sign in", false if cancelled.
Future<bool?> showSignInToFavoriteDialog(
  BuildContext context, {
  required MovieEntity movie,
}) {
  final theme = Theme.of(context);
  final textTheme = theme.textTheme;
  final colorScheme = theme.colorScheme;

  return showDialog<bool>(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: AppRadii.card),
      child: Padding(
        padding: const EdgeInsets.all(AppSizing.spaceXl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSizing.spaceLg),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.favorite_border_rounded,
                size: 40,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: AppSizing.spaceLg),
            Text(
              'Sign in to add favorites',
              style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizing.spaceSm),
            Text(
              '“${movie.title}” will be added to your favorites after you sign in.',
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSizing.spaceXl),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(AppSizing.buttonHeight),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: AppSizing.spaceMd),
                Expanded(
                  child: FilledButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(AppSizing.buttonHeight),
                    ),
                    child: const Text('Sign in'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
