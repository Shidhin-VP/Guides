import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone_client/core/constants/server_constants.dart';
import 'package:spotify_clone_client/core/failure/app_failure.dart';
import 'package:spotify_clone_client/features/home/model/song_model.dart';

part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(Ref ref) {
  return HomeRepository();
}

class HomeRepository {
  Future<Either<AppFailure, SongModel>> uploadSongs(
    String songFileName,
    String thumbnailFileName,
    String songName,
    String artistName,
    String hexCode,
    String token,
  ) async {
    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse("${ServerConstants.serverConstant}/api/song/save_song"),
      );
      request
        ..files.addAll([
          await http.MultipartFile.fromPath("song", songFileName),
          await http.MultipartFile.fromPath("thumbnail", thumbnailFileName),
        ])
        ..fields.addAll({
          "song_name": songName,
          "artist": artistName,
          "hex_code": hexCode,
        })
        ..headers.addAll({"x-auth-token": token});
      final streamedResponse = await request.send();
      final res = await http.Response.fromStream(streamedResponse);
      print("Res: $res");
      final resBodyStatus = jsonDecode(res.body);
      print("ResBody: $resBodyStatus");
      if (res.statusCode != 201) {
        Left(AppFailure(message: resBodyStatus['detail']));
      }
      return Right(SongModel.fromMap(resBodyStatus));
    } catch (e) {
      print("Error: $e");
      return Left(AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, List<SongModel>>> listSongs(String token) async {
    try {
      final res = await http.get(
        Uri.parse("${ServerConstants.serverConstant}/api/song/library"),
        headers: {"Content-Type": "application/json", "x-auth-token": token},
      );
      var resBodyStatus = jsonDecode(res.body);
      print("ResBodyStatus: $resBodyStatus");
      print("Tyep: ${resBodyStatus.runtimeType}");
      if (res.statusCode != 200) {
        return Left(AppFailure(message: resBodyStatus['detail']));
      }
      return Right(SongModel.convertToListModel(resBodyStatus));
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }
}
