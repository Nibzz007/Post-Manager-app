import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_manager_app/domain/entities/movie_entity.dart';
import 'package:post_manager_app/injection_container.dart' as di;
import 'package:post_manager_app/presentation/favorites/bloc/favorites_bloc.dart';
import 'package:post_manager_app/presentation/favorites/pages/favorites_page.dart';
import 'package:post_manager_app/presentation/movies/bloc/movie_bloc.dart';
import 'package:post_manager_app/presentation/movies/pages/movies_page.dart';
import 'package:post_manager_app/presentation/profile/pages/profile_page.dart';

class MainShell extends StatefulWidget {
  final MovieEntity? pendingFavorite;

  const MainShell({super.key, this.pendingFavorite});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;
  bool _didHandlePending = false;

  static List<Widget> _pages(int index) => [
        const MoviesPage(),
        const FavoritesPage(),
        const ProfilePage(),
      ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<MovieBloc>()..add(const LoadPopularMoviesEvent())),
        BlocProvider(create: (_) => di.sl<FavoritesBloc>()..add(LoadFavoritesEvent())),
      ],
      child: Builder(
        builder: (context) {
          if (widget.pendingFavorite != null && !_didHandlePending) {
            _didHandlePending = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!context.mounted) return;
              context.read<FavoritesBloc>().add(AddFavoriteEvent(widget.pendingFavorite!));
            });
          }
          return Scaffold(
            body: IndexedStack(
              index: _index,
              children: _pages(_index),
            ),
            bottomNavigationBar: NavigationBar(
              selectedIndex: _index,
              onDestinationSelected: (i) => setState(() => _index = i),
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.movie_outlined),
                  selectedIcon: Icon(Icons.movie),
                  label: 'Movies',
                ),
                NavigationDestination(
                  icon: Icon(Icons.favorite_border),
                  selectedIcon: Icon(Icons.favorite),
                  label: 'Favorites',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
