import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_manager_app/core/theme/theme.dart';
import 'package:post_manager_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:post_manager_app/presentation/auth/cubit/auth_state.dart';
import 'package:post_manager_app/presentation/auth/pages/auth_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (a, b) => a.isGuest != b.isGuest || a.user != b.user,
      builder: (context, authState) {
        final isGuest = authState.isGuest;
        final user = authState.user;

        return Scaffold(
          appBar: AppBar(title: const Text('Profile')),
          body: Padding(
            padding: const EdgeInsets.all(AppSizing.spaceLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.person_outline_rounded,
                  size: AppSizing.iconEmpty,
                  color: colorScheme.primary.withValues(alpha: 0.5),
                ),
                const SizedBox(height: AppSizing.spaceXl),
                Text(
                  isGuest ? 'Guest' : (user?.email ?? 'Signed in'),
                  style: textTheme.headlineSmall?.copyWith(color: colorScheme.onSurface),
                ),
                const SizedBox(height: AppSizing.spaceSm),
                Text(
                  isGuest
                      ? 'You’re using the app without an account.'
                      : 'You’re signed in. Your favorites are saved to your account.',
                  style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                ),
                const SizedBox(height: AppSizing.spaceXl),
                if (isGuest)
                  FilledButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const AuthPage()),
                        (route) => false,
                      );
                    },
                    icon: const Icon(Icons.login_rounded, size: AppSizing.iconSm),
                    label: const Text('Sign in'),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(AppSizing.buttonHeight),
                    ),
                  )
                else
                  OutlinedButton.icon(
                    onPressed: () async {
                      await context.read<AuthCubit>().signOut();
                      if (!context.mounted) return;
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const AuthPage()),
                        (route) => false,
                      );
                    },
                    icon: const Icon(Icons.logout_rounded, size: AppSizing.iconSm),
                    label: const Text('Log out'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(AppSizing.buttonHeight),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
