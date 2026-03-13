import 'package:flutter/material.dart';
import 'package:post_manager_app/core/constants/api_end_points.dart';
import 'package:post_manager_app/core/theme/theme.dart';
import 'package:post_manager_app/domain/entities/movie_entity.dart';

class MovieCard extends StatelessWidget {
  final MovieEntity movie;
  final VoidCallback? onTap;
  final Widget? trailing;

  const MovieCard({
    super.key,
    required this.movie,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final posterUrl = movie.posterPath != null
        ? '${ApiEndPoints.tmdbImageBaseUrl}${movie.posterPath}'
        : null;

    return Material(
      color: colorScheme.surfaceContainerLow,
      borderRadius: AppRadii.card,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSizing.spaceSm),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: AppRadii.radiusSm,
                child: SizedBox(
                  width: 80,
                  height: 120,
                  child: posterUrl != null
                      ? Image.network(
                          posterUrl,
                          fit: BoxFit.cover,
                          width: 80,
                          height: 120,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color: colorScheme.surfaceContainerHighest,
                              child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                            );
                          },
                          errorBuilder: (_, __, ___) => Icon(Icons.movie_outlined, size: 40, color: colorScheme.onSurfaceVariant),
                        )
                      : Icon(Icons.movie_outlined, size: 40, color: colorScheme.onSurfaceVariant),
                ),
              ),
              const SizedBox(width: AppSizing.spaceMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: textTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (movie.releaseDate != null && movie.releaseDate!.isNotEmpty) ...[
                      const SizedBox(height: AppSizing.spaceXs),
                      Text(
                        movie.releaseDate!.length >= 4 ? movie.releaseDate!.substring(0, 4) : movie.releaseDate!,
                        style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                      ),
                    ],
                    if (movie.voteAverage > 0) ...[
                      const SizedBox(height: AppSizing.spaceXs),
                      Row(
                        children: [
                          Icon(Icons.star_rounded, size: 14, color: Colors.amber.shade700),
                          const SizedBox(width: 4),
                          Text(
                            movie.voteAverage.toStringAsFixed(1),
                            style: textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ],
                    if (trailing != null) ...[
                      const SizedBox(height: AppSizing.spaceSm),
                      trailing!,
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
