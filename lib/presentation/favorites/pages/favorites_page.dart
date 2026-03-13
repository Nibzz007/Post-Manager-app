import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_manager_app/core/theme/theme.dart';
import 'package:post_manager_app/core/widgets/widgets.dart';
import 'package:post_manager_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:post_manager_app/presentation/auth/cubit/auth_state.dart';
import 'package:post_manager_app/presentation/auth/pages/auth_page.dart';
import 'package:post_manager_app/presentation/favorites/bloc/favorites_bloc.dart';
import 'package:post_manager_app/presentation/movies/pages/movie_detail_page.dart';
import 'package:post_manager_app/presentation/movies/widgets/movie_card.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    context.read<FavoritesBloc>().add(LoadFavoritesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: BlocBuilder<AuthCubit, AuthState>(
        buildWhen: (prev, next) => prev.isGuest != next.isGuest,
        builder: (context, authState) {
          final isGuest = authState.isGuest;
          return BlocBuilder<FavoritesBloc, FavoritesState>(
            builder: (context, state) {
              if (state is FavoritesLoading) {
                return const AppLoader(message: 'Loading favorites…');
              }
              if (state is FavoritesError) {
                return ErrorView(
                  message: state.message,
                  onRetry: () => context.read<FavoritesBloc>().add(LoadFavoritesEvent()),
                );
              }
              if (state is FavoritesLoaded) {
                if (isGuest) {
                  return _GuestFavoritesView(
                    onSignIn: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const AuthPage()),
                        (route) => false,
                      );
                    },
                  );
                }
                if (state.movies.isEmpty) {
                  return EmptyState(
                    title: 'No favorites yet',
                    subtitle: 'Tap the heart on a movie to add it here.',
                    icon: Icons.favorite_border,
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<FavoritesBloc>().add(LoadFavoritesEvent());
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
                      );
                    },
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}

class _GuestFavoritesView extends StatelessWidget {
  final VoidCallback onSignIn;

  const _GuestFavoritesView({required this.onSignIn});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizing.spaceLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: AppRadii.card),
            child: Padding(
              padding: const EdgeInsets.all(AppSizing.spaceLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.favorite_border_rounded, color: colorScheme.primary, size: 28),
                      const SizedBox(width: AppSizing.spaceMd),
                      Expanded(
                        child: Text(
                          'Sign in to save favorites',
                          style: textTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizing.spaceSm),
                  Text(
                    'Your favorite movies will be saved to your account and sync across devices.',
                    style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: AppSizing.spaceLg),
                  FilledButton.icon(
                    onPressed: onSignIn,
                    icon: const Icon(Icons.login_rounded, size: AppSizing.iconSm),
                    label: const Text('Sign in'),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(AppSizing.buttonHeight),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
