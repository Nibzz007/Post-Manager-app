import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_manager_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:post_manager_app/presentation/auth/cubit/auth_state.dart';
import 'package:post_manager_app/presentation/auth/pages/auth_page.dart';
import 'package:post_manager_app/presentation/main_shell.dart';

/// Decides whether to show [AuthPage] or [MainShell] based on auth state.
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state.user != null) {
          return const MainShell(pendingFavorite: null);
        }
        return const AuthPage();
      },
    );
  }
}
