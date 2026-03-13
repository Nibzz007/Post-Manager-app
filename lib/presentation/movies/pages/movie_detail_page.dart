import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_manager_app/core/constants/api_end_points.dart';
import 'package:post_manager_app/core/theme/theme.dart';
import 'package:post_manager_app/domain/entities/movie_entity.dart';
import 'package:post_manager_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:post_manager_app/presentation/auth/pages/auth_page.dart';
import 'package:post_manager_app/presentation/auth/widgets/sign_in_to_favorite_dialog.dart';
import 'package:post_manager_app/presentation/favorites/bloc/favorites_bloc.dart';

class MovieDetailPage extends StatelessWidget {
  final MovieEntity movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final posterUrl = movie.posterPath != null
        ? '${ApiEndPoints.tmdbImageBaseUrl}${movie.posterPath}'
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          movie.title,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          BlocBuilder<FavoritesBloc, FavoritesState>(
            builder: (context, state) {
              final isFav = state is FavoritesLoaded && state.ids.contains(movie.id);
              return IconButton(
                icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: isFav ? Colors.red : null),
                onPressed: () async {
                  if (isFav) {
                    context.read<FavoritesBloc>().add(RemoveFavoriteEvent(movie.id));
                    return;
                  }
                  final isGuest = context.read<AuthCubit>().state.isGuest;
                  if (isGuest) {
                    final signIn = await showSignInToFavoriteDialog(context, movie: movie);
                    if (signIn == true && context.mounted) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => AuthPage(pendingFavorite: movie)),
                        (route) => false,
                      );
                    }
                  } else {
                    context.read<FavoritesBloc>().add(AddFavoriteEvent(movie));
                  }
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizing.spaceLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (posterUrl != null)
              Center(
                child: ClipRRect(
                  borderRadius: AppRadii.card,
                  child: Image.network(
                    posterUrl,
                    width: double.infinity,
                    height: 400,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const SizedBox(height: 400, child: Center(child: CircularProgressIndicator()));
                    },
                    errorBuilder: (_, __, ___) => const SizedBox(height: 200, child: Center(child: Icon(Icons.movie_outlined, size: 64))),
                  ),
                ),
              ),
            const SizedBox(height: AppSizing.spaceXl),
            Text(
              movie.title,
              style: textTheme.headlineSmall?.copyWith(color: colorScheme.onSurface),
            ),
            if (movie.releaseDate != null && movie.releaseDate!.isNotEmpty) ...[
              const SizedBox(height: AppSizing.spaceSm),
              Text(
                movie.releaseDate!,
                style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
            ],
            if (movie.voteAverage > 0) ...[
              const SizedBox(height: AppSizing.spaceSm),
              Row(
                children: [
                  Icon(Icons.star_rounded, size: 20, color: Colors.amber.shade700),
                  const SizedBox(width: 6),
                  Text(
                    '${movie.voteAverage.toStringAsFixed(1)} / 10',
                    style: textTheme.titleSmall?.copyWith(color: colorScheme.onSurface),
                  ),
                ],
              ),
            ],
            if (movie.overview != null && movie.overview!.isNotEmpty) ...[
              const SizedBox(height: AppSizing.spaceLg),
              Text(
                'Overview',
                style: textTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
              ),
              const SizedBox(height: AppSizing.spaceSm),
              Text(
                movie.overview!,
                style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant, height: 1.5),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
