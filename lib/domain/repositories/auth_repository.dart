import 'package:dartz/dartz.dart';
import 'package:post_manager_app/core/error/failures.dart';
import 'package:post_manager_app/domain/entities/auth_user.dart';

abstract class AuthRepository {
  Stream<AuthUser?> get authStateChanges;

  Future<Either<Failure, void>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
