import 'dart:convert';

import 'package:hive_ce/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone_client/features/home/model/song_model.dart';

part 'home_local_repository.g.dart';

@riverpod
HomeLocalRepository homeLocalRepository(Ref ref) {
  return HomeLocalRepository();
}

class HomeLocalRepository {
  final Box songBox = Hive.box('hiveSongBox');
  void uploadLocalSong(SongModel song) {
    songBox.put(song.songID, song.toJson());
  }

  List<SongModel> getLocalSongs() {
    List<SongModel> songList = [];
    for (final key in songBox.keys) {
      print(" Song Value: ${songBox.get(key)}");
      songList.add(SongModel.fromMap(jsonDecode(songBox.get(key))));
    }
    print("SongList; $songList");
    print("SongList: ${songList[0]}");
    print("SongModle List: ${songList[0].artistName}");
    return songList;
  }
}
