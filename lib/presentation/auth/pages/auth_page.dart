import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_manager_app/core/theme/theme.dart';
import 'package:post_manager_app/domain/entities/movie_entity.dart';
import 'package:post_manager_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:post_manager_app/presentation/auth/cubit/auth_state.dart';
import 'package:post_manager_app/presentation/main_shell.dart';

class AuthPage extends StatefulWidget {
  final MovieEntity? pendingFavorite;
  final bool isSignUpMode;

  const AuthPage({
    super.key,
    this.pendingFavorite,
    this.isSignUpMode = false,
  });

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  late bool _isSignUpMode;

  @override
  void initState() {
    super.initState();
    _isSignUpMode = widget.isSignUpMode;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _goToMain(bool isGuest) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => MainShell(
          pendingFavorite: isGuest ? null : widget.pendingFavorite,
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (_isSignUpMode) {
      await context.read<AuthCubit>().signUpWithEmailAndPassword(
            email: email,
            password: password,
          );
    } else {
      await context.read<AuthCubit>().signInWithEmailAndPassword(
            email: email,
            password: password,
          );
    }

    if (!mounted) return;
    final state = context.read<AuthCubit>().state;
    if (state.errorMessage == null && !state.isGuest) {
      _goToMain(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSizing.space2xl),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48),
                Text(
                  _isSignUpMode ? 'Create account' : 'Welcome',
                  style: textTheme.headlineMedium?.copyWith(color: colorScheme.onSurface),
                ),
                const SizedBox(height: AppSizing.spaceSm),
                Text(
                  widget.pendingFavorite != null
                      ? 'Sign in and “${widget.pendingFavorite!.title}” will be added to your favorites.'
                      : (_isSignUpMode
                          ? 'Enter your details to get started.'
                          : 'Sign in with your email and password.'),
                  style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                ),
                const SizedBox(height: AppSizing.space2xl),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'you@example.com',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Enter your email';
                    if (!v.contains('@') || !v.contains('.')) return 'Enter a valid email';
                    return null;
                  },
                ),
                const SizedBox(height: AppSizing.spaceLg),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Enter your password';
                    if (_isSignUpMode && v.length < 6) return 'Use at least 6 characters';
                    return null;
                  },
                ),
                const SizedBox(height: AppSizing.spaceSm),
                BlocBuilder<AuthCubit, AuthState>(
                  buildWhen: (a, b) => a.errorMessage != b.errorMessage,
                  builder: (context, state) {
                    if (state.errorMessage == null) return const SizedBox.shrink();
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSizing.spaceMd),
                      child: Text(
                        state.errorMessage!,
                        style: TextStyle(color: colorScheme.error, fontSize: 13),
                      ),
                    );
                  },
                ),
                FilledButton(
                  onPressed: () async => _submit(),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(AppSizing.buttonHeight),
                  ),
                  child: BlocBuilder<AuthCubit, AuthState>(
                    buildWhen: (a, b) => a.isLoading != b.isLoading,
                    builder: (context, state) {
                      return state.isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(_isSignUpMode ? 'Sign up' : 'Sign in');
                    },
                  ),
                ),
                const SizedBox(height: AppSizing.spaceMd),
                TextButton(
                  onPressed: () {
                    context.read<AuthCubit>().clearError();
                    setState(() => _isSignUpMode = !_isSignUpMode);
                  },
                  child: Text(
                    _isSignUpMode
                        ? 'Already have an account? Sign in'
                        : "Don't have an account? Sign up",
                  ),
                ),
                const SizedBox(height: AppSizing.spaceLg),
                const Divider(),
                const SizedBox(height: AppSizing.spaceSm),
                TextButton(
                  onPressed: () => _goToMain(true),
                  child: const Text('Skip – continue as guest'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
