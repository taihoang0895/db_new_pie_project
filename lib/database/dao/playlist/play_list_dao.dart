import 'package:floor/floor.dart';

import '../../entities/playlist/play_list_entity.dart';
import '../../entities/stream/stream_entity.dart';

@dao
abstract class PlaylistDao {
  //playlist

  @Query('SELECT * FROM $playListTableName')
  Stream<List<PlaylistEntity>> findAllAsStream();

  @Query('SELECT * FROM $playListTableName')
  Future<List<PlaylistEntity>> findAll();

  @Query(
      'SELECT * FROM $playListTableName WHERE $playListTableName.id = :playListID')
  Future<PlaylistEntity?> findPlayListByID(int playListID);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> addPlaylist(PlaylistEntity playList);

  @delete
  Future<int> deletePlayList(PlaylistEntity playlistEntity);

  @Query('DELETE FROM $playListTableName WHERE id = :playListId')
  Future<void> deletePlayListByID(int playListId);

  @update
  Future<int> renamePlayList(PlaylistEntity playlistEntity);

  @Query('DELETE FROM $playListTableName')
  Future<void> clearPLayList();
}
