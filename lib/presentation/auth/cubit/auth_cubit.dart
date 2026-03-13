import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_manager_app/domain/entities/auth_user.dart';
import 'package:post_manager_app/domain/repositories/auth_repository.dart';
import 'package:post_manager_app/presentation/auth/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository;
  StreamSubscription<AuthUser?>? _authSubscription;

  AuthCubit(this._repository) : super(const AuthState()) {
    _authSubscription = _repository.authStateChanges.listen((user) {
      emit(state.copyWith(
        isGuest: user == null,
        user: user,
        errorMessage: null,
      ));
    });
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await _repository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(isLoading: false, errorMessage: null)),
    );
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await _repository.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );
    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(isLoading: false, errorMessage: null)),
    );
  }

  Future<void> signOut() async {
    await _repository.signOut();
  }

  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
