import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_manager_app/core/theme/theme.dart';
import 'package:post_manager_app/core/widgets/widgets.dart';
import 'package:post_manager_app/presentation/auth/pages/auth_page.dart';
import 'package:post_manager_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:post_manager_app/presentation/auth/widgets/sign_in_to_favorite_dialog.dart';
import 'package:post_manager_app/presentation/favorites/bloc/favorites_bloc.dart';
import 'package:post_manager_app/presentation/movies/bloc/movie_bloc.dart';
import 'package:post_manager_app/presentation/movies/pages/movie_detail_page.dart';
import 'package:post_manager_app/domain/entities/movie_entity.dart';
import 'package:post_manager_app/presentation/movies/widgets/movie_card.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(const LoadPopularMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movies')),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const AppLoader(message: 'Loading movies…');
          }
          if (state is MovieError) {
            return ErrorView(
              message: state.message,
              onRetry: () => context.read<MovieBloc>().add(const LoadPopularMoviesEvent()),
            );
          }
          if (state is MovieListLoaded) {
            if (state.movies.isEmpty) {
              return EmptyState(
                title: 'No movies',
                subtitle: 'Pull down to refresh.',
                icon: Icons.movie_outlined,
                onAction: () => context.read<MovieBloc>().add(RefreshPopularMoviesEvent()),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<MovieBloc>().add(RefreshPopularMoviesEvent());
              },
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(
                  AppSizing.listPaddingH,
                  AppSizing.listPaddingV,
                  AppSizing.listPaddingH,
                  AppSizing.listPaddingBottom,
                ),
                itemCount: state.movies.length,
                separatorBuilder: (_, __) => const SizedBox(height: AppSizing.listItemGap),
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return MovieCard(
                    movie: movie,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<FavoritesBloc>(),
                          child: MovieDetailPage(movie: movie),
                        ),
                      ),
                    ),
                    trailing: _FavoriteButton(movie: movie),
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  final MovieEntity movie;

  const _FavoriteButton({required this.movie});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, favState) {
        final isFav = favState is FavoritesLoaded && favState.ids.contains(movie.id);
        return IconButton(
          icon: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            color: isFav ? Colors.red : Theme.of(context).colorScheme.onSurfaceVariant,
            size: AppSizing.iconSm,
          ),
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
    );
  }
}
