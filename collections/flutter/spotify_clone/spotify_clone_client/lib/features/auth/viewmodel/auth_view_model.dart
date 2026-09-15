import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone_client/core/providers/current_user_notifier.dart';
import 'package:spotify_clone_client/features/auth/model/repositories/auth_local_repository.dart';
import 'package:spotify_clone_client/features/auth/model/repositories/auth_remote_repository.dart';
import 'package:spotify_clone_client/features/auth/model/user_model.dart';

part 'auth_view_model.g.dart';

@Riverpod(keepAlive: true)
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository;
  late AuthLocalRepository _authLocalRepository;
  late CurrentUserNotifier _currentUserNotifier;

  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserProvider.notifier);
    return null;
  }

  Future<void> initSharedPreferences() async {
    return await _authLocalRepository.initSharedPreferences();
  }

  Future<void>? signUpUser(String name, String email, String password) async {
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
      Right(value: final r) => loginUserwithToken(r),
    };
  }

  AsyncValue<UserModel>? loginUserwithToken(UserModel user) {
    _authLocalRepository.setToken(user.token);
    _currentUserNotifier.addUser(user);
    return state = AsyncData(user);
  }

  Future<UserModel?> validateAndGetToken() async {
    state = AsyncLoading();
    final String? token = _authLocalRepository.getToken();
    if (token != null && token.isNotEmpty) {
      final res = await _authRemoteRepository.getTokenValidatedData(token);
      print(res);
      if (!ref.mounted) {
        print("needed to quit");
        return null;
      }
      final result = switch (res) {
        Left(value: final l) => state = AsyncError(
          l.message,
          StackTrace.current,
        ),
        Right(value: final r) => _getDataSuccess(r!),
      };
      return result.value;
    }
    return null;
  }

  AsyncValue<UserModel> _getDataSuccess(UserModel user){
    _currentUserNotifier.addUser(user);
    return state=AsyncValue.data(user);
  }
}
