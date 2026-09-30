/*
        user_id:UUID
        song_url:str
        artist_name:str
        color:str
        song_name:str 
        id: UUID
        thumbnail_url:str
*/

import 'dart:convert';

class SongModel {
  String? userID;
  String songURL;
  String artistName;
  String songName;
  String color;
  String? songID;
  String thumbnailURL;
  SongModel({
    required this.songURL,
    required this.artistName,
    required this.songName,
    required this.thumbnailURL,
    required this.color,
    this.userID,
    this.songID,
  });

  SongModel copyWith({
    String? songURL,
    String? artistName,
    String? songName,
    String? thumbnailURL,
    String? color,
  }) {
    return SongModel(
      songURL: songURL ?? this.songURL,
      artistName: artistName ?? this.artistName,
      songName: songName ?? this.songName,
      thumbnailURL: thumbnailURL ?? this.thumbnailURL,
      color: color ?? this.color,
    );
  }

  factory SongModel.fromMap(Map map) {
    return SongModel(
      songURL: map["song_url"] ?? map['songURL'] ?? '',
      songName: map["song_name"] ?? map['songName'] ?? '',
      artistName: map["artist_name"] ?? map['artistName'] ?? '',
      thumbnailURL: map["thumbnail_url"] ?? map['thumbnailURL'] ?? '',
      color: map["color"] ?? '',
      userID: map["user_id"] ?? map['userID'] ?? '',
      songID: map["id"] ?? map['songID'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userID': userID,
      'songID': songID,
      'songURL': songURL,
      'songName': songName,
      'artistName': artistName,
      'thumbnailURL': thumbnailURL,
      'color': color,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  static List<SongModel> convertToListModel(List res) {
    List<SongModel> finalList = [];
    for (Map song in res) {
      finalList.add(SongModel.fromMap(song));
    }
    return finalList;
  }
}
