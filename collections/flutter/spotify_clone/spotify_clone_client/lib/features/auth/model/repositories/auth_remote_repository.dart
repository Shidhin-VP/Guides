import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone_client/core/constants/server_constants.dart';
import 'package:spotify_clone_client/core/failure/app_failure.dart';
import 'package:spotify_clone_client/features/auth/model/user_model.dart';

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(Ref ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  Future<Either<AppFailure, UserModel>> signUp(
    String name,
    String email,
    String password,
  ) async {
    try {
      final res = await http.post(
        Uri.parse("${ServerConstants.serverConstant}/api/auth/signup"),
        headers: {"Content-Type": "application/json"},
        body: UserModel(name: name, email: email, password: password).toJson(),
      );
      final resBodyMap = jsonDecode(res.body) as Map<String, dynamic>;
      if (res.statusCode != 201) {
        return Left(AppFailure(message: resBodyMap['detail']));
      }
      return Right(UserModel.fromMap(resBodyMap));
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, UserModel>> login(
    String email,
    String password,
  ) async {
    try {
      final res = await http.post(
        Uri.parse("${ServerConstants.serverConstant}/api/auth/signin"),
        headers: {"Content-Type": "application/json"},
        body: UserModel(email: email, password: password).toJson(),
      );
      final resBodyMap = jsonDecode(res.body);
      print(resBodyMap);
      if (res.statusCode != 200) {
        return Left(AppFailure(message: resBodyMap['detail']));
      }
      return Right(UserModel.fromMap(resBodyMap));
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }
}
