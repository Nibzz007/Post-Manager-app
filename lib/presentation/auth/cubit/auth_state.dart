import 'package:equatable/equatable.dart';
import 'package:post_manager_app/domain/entities/auth_user.dart';

class AuthState extends Equatable {
  final bool isGuest;
  final AuthUser? user;
  final bool isLoading;
  final String? errorMessage;

  const AuthState({
    this.isGuest = true,
    this.user,
    this.isLoading = false,
    this.errorMessage,
  });

  AuthState copyWith({
    bool? isGuest,
    AuthUser? user,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthState(
      isGuest: isGuest ?? this.isGuest,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isGuest, user, isLoading, errorMessage];
}
