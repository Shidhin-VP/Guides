import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone_client/features/auth/model/repositories/auth_remote_repository.dart';
import 'package:spotify_clone_client/features/auth/model/user_model.dart';

part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository;

  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    return null;
  }

  Future<void> signUpUser(String name, String email, String password) async {
    state = AsyncLoading();
    final res = await _authRemoteRepository.signUp(name, email, password);
    final result = switch (res) {
      Left(value: final l) => state = AsyncError(l.message, StackTrace.current),
      Right(value: final r) => state = AsyncData(r),
    };
  }

  Future<void> loginUser(String email, String password) async {
    state = AsyncLoading();
    final res = await _authRemoteRepository.login(email, password);
    final result = switch (res) {
      Left(value: final l) => state = AsyncError(l.message, StackTrace.current),
      Right(value: final r) => state = AsyncData(r),
    };
  }
}
