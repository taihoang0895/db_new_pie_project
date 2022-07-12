import 'package:floor/floor.dart';
import '../../entities/history/stream_state_entity.dart';
import '../../entities/playlist/play_list_entity.dart';
import '../../entities/playlist/play_list_detail_entity.dart';
import '../../entities/stream/stream_entity.dart';

@dao
abstract class PlayListDetailsDao {

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addPlaylistDetail(PlaylistDetailEntity detailEntity);

  @update
  Future<void> updatePlayListDetail(PlaylistDetailEntity detailEntity);

  @delete
  Future<int> deletePlayListDetail(PlaylistDetailEntity detailEntity);


  @Query(  'SELECT pl.*,st.* FROM ${PlaylistEntity.tableName} pl INNER JOIN  ${PlaylistDetailEntity.tableName} dt on pl.id = dt.playlistId INNER JOIN ${StreamEntity.tableName} st ON st.uid = dt.streamId INNER JOIN ${StreamStateEntity.tableName} sst ON st.uid = sst.streamId WHERE pl.id = :playListId ORDER BY dt.joinIndex ASC')
  Future<List<StreamStateEntity>> getStreamFromPlayList(int playListId);


  @Query(
      "SELECT * FROM $playListDetailTableName p WHERE p.playlistId = :playListId")
  Future<List<PlaylistDetailEntity>> getPlayListDetail(int playListId);

  @Query(
      "DELETE FROM $playListDetailTableName WHERE PlaylistDetail.playlistId = :playListId AND PlaylistDetail.streamId = :streamId ")
  Future<void> deleteStreamFromPlayList(int playListId, int streamId);

  @Query('DELETE FROM $playListDetailTableName')
  Future<void> clearDetails();

  @Query('SELECT * FROM $playListDetailTableName')
  Future<List<PlaylistDetailEntity>> findAll();

  @Query('SELECT * FROM $playListDetailTableName')
  Stream<List<PlaylistDetailEntity>> findAllAsStream();
}
