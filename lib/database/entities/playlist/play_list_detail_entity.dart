import 'package:floor/floor.dart';

const playListDetailTableName = "PlaylistDetail";

@Entity(
    tableName: PlaylistDetailEntity.tableName,
    primaryKeys: ['playlistId', 'streamId'])
class PlaylistDetailEntity {
  int playlistId;

  String streamId;

  int joinIndex;

  PlaylistDetailEntity(
      {required this.playlistId,
      required this.streamId,
      required this.joinIndex});

  PlaylistDetailEntity.clone(PlaylistDetailEntity obj)
      : this(
            playlistId: obj.playlistId,
            streamId: obj.streamId,
            joinIndex: obj.joinIndex);

  static const int defaultJoinIndex = 0;
  static const String tableName = "PlaylistDetail";
}
