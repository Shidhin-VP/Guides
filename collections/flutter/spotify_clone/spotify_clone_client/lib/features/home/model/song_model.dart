/*
        user_id:UUID
        song_url:str
        artist_name:str
        color:str
        song_name:str 
        id: UUID
        thumbnail_url:str
*/

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

  factory SongModel.fromMap(Map map) {
    return SongModel(
      songURL: map["song_url"],
      songName: map["song_name"],
      artistName: map["artist_name"],
      thumbnailURL: map["thumbnail_url"],
      color: map["color"],
      userID: map["user_id"],
      songID: map["id"],
    );
  }

  static List<SongModel> convertToListModel(List res) {
    List<SongModel> finalList = [];
    for (Map song in res) {
      finalList.add(SongModel.fromMap(song));
    }
    return finalList;
  }
}
