import 'dart:async';

import 'package:db_new_pie_project/database/entities/entities.dart';
import 'package:floor/floor.dart';

import '../../app_database.dart';
import '../../entities/playlist/play_list_data.dart';
import '../../entities/playlist/play_list_entity.dart';
import '../../entities/playlist/play_list_detail_entity.dart';
import '../../entities/stream/stream_entity.dart';
import 'play_list_dao.dart';
import 'play_list_details_dao.dart';

class PlayListManager {
  final AppDatabase appDatabase;
  final QueryAdapter _queryAdapter;

  PlayListManager(this.appDatabase)
      : _queryAdapter = appDatabase.buildQueryAdapter();

  PlaylistDao get playListDao => appDatabase.playListDao;

  PlayListDetailsDao get detailsDao => appDatabase.detailsDao;

  String sqlQueryStreams =
      'SELECT pl.*,st.*,sst.* FROM ${PlaylistEntity.tableName} pl '
      'INNER JOIN  ${PlaylistDetailEntity.tableName} dt on pl.id = dt.playlistId '
      'INNER JOIN ${StreamEntity.tableName} st ON st.uid = dt.streamId '
      'INNER JOIN ${StreamStateEntity.tableName} sst ON st.uid = sst.streamId '
      'WHERE pl.id = ?1 ORDER BY dt.joinIndex ASC';

  Stream<List<PlayListData>> _getStreamDataFromPlayList(int playListId) {
    return _queryAdapter.queryListStream(sqlQueryStreams,
        mapper: (Map<String, Object?> row) => PlayListData(
              PlaylistEntity(row['id'] as int, row['name'] as String),
              StreamEntity(
                  row['uid'] as int,
                  row['url'] as String,
                  row['tile'] as String,
                  row['streamType'] as String,
                  row['duration'] as int,
                  row['uploader'] as String,
                  row['uploaderUrl'] as String,
                  row['viewCount'] as int,
                  row['textualUploadDate'] as String,
                  row['uploadDate'] as int),
              StreamStateEntity(
                  row['streamId'] as int, row['progressTime'] as int),
            ),
        arguments: [playListId],
        queryableName: 'PlayListData',
        isView: false);
  }

//using unit test
  Future<List<PlayListData>> getStreamData(int playListId) {
    return _queryAdapter.queryList(sqlQueryStreams,
        mapper: (Map<String, Object?> row) => PlayListData(
            PlaylistEntity(row['id'] as int, row['name'] as String),
            StreamEntity(
                row['uid'] as int,
                row['url'] as String,
                row['tile'] as String,
                row['streamType'] as String,
                row['duration'] as int,
                row['uploader'] as String,
                row['uploaderUrl'] as String,
                row['viewCount'] as int,
                row['textualUploadDate'] as String,
                row['uploadDate'] as int),
            StreamStateEntity(
                row['streamId'] as int, row['progressTime'] as int)),
        arguments: [playListId]);
  }

  Future<void> addStreamToPlayList(int playId, int streamId) async {
    var data = await getStreamData(playId);

    await detailsDao.addPlaylistDetail(PlaylistDetailEntity(
        playlistId: playId, streamId: streamId, joinIndex: data.length + 1));
  }

  Future<void> createPlaylist(
      PlaylistEntity playlistEntity, int streamId) async {
    playListDao.addPlaylist(playlistEntity);

    detailsDao.addPlaylistDetail(PlaylistDetailEntity(
        playlistId: playlistEntity.id,
        streamId: streamId,
        joinIndex: PlaylistDetailEntity.defaultJoinIndex));
  }

  Future<void> deletePlayList(int playListId) async {
    await playListDao.deletePlayListByID(playListId);
  }

  Stream<List<PlaylistEntity>> findAllPlayListAsStream() {
    return playListDao.findAllAsStream();
  }

  Future<List<PlaylistEntity>> findAllPlayList() async {
    return playListDao.findAll();
  }


  Future<List<PlaylistDetailEntity>> findAllPlayListDetail() async {
    return detailsDao.findAll();
  }

  Stream<List<PlayListData>> getListStreamFromPlayList(int playListId) {
    return _getStreamDataFromPlayList(playListId);
  }

  Future<void> reOderListStream(
      int playListId, List<PlayListData> items) async {
    items.asMap().forEach((key, value) {
      detailsDao.updatePlayListDetail(PlaylistDetailEntity.clone(
          PlaylistDetailEntity(
              playlistId: playListId,
              streamId: value.streamEntity.uid,
              joinIndex: key)));
    });
  }

  Future<void> removeStreamFromPLayList(int playListId, int streamId) async {
    await detailsDao.deleteStreamFromPlayList(playListId, streamId);
  }

  Future<void> updateNamePlayList(String playListName, int playListId) async {
    await playListDao.renamePlayList(PlaylistEntity(playListId, playListName));
  }
}
