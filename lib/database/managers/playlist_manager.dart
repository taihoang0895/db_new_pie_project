import 'dart:async';
import 'package:floor/floor.dart';

import '../app_database.dart';
import '../dao/history/history_dao.dart';
import '../dao/playlist/play_list_dao.dart';
import '../dao/playlist/play_list_details_dao.dart';
import 'package:db_new_pie_project/database/entities/entities.dart';

const int maxIntValue = 0x7fffffff;

class PlayListManager {
  final AppDatabase appDatabase;
  final QueryAdapter _queryAdapter;

  PlayListManager(this.appDatabase)
      : _queryAdapter = appDatabase.buildQueryAdapter();

  PlaylistDao get playListDao => appDatabase.playListDao;

  PlayListDetailsDao get detailsDao => appDatabase.detailsDao;

  HistoryDao get historyDao => appDatabase.historyDao;

  String sqlQueryStreams = """
      SELECT dt.*,
             st.*,
             sst.*
      FROM ${PlaylistEntity.tableName} pl
      INNER JOIN ${PlaylistDetailEntity.tableName} dt ON pl.id = dt.playlistId
      INNER JOIN ${StreamEntity.tableName} st ON st.uid = dt.streamId
      INNER JOIN ${StreamStateEntity.tableName} sst ON st.uid = sst.streamId
      WHERE pl.id = ?1
      ORDER BY dt.joinIndex ASC
     """;

  Stream<List<StreamData>> _getStreamDataFromPlayList(int playListId) {
    return _queryAdapter.queryListStream(sqlQueryStreams,
        mapper: (Map<String, Object?> row) => StreamData(
            StreamEntity(
                row['uid'] as String,
                row['url'] as String,
                row['tile'] as String,
                row['streamType'] as String,
                row['duration'] as int,
                row['uploader'] as String,
                row['uploaderUrl'] as String,
                row['viewCount'] as int,
                row['textualUploadDate'] as String,
                row['uploadDate'] as int),
            row['progressTime'] as int,
            row['joinIndex'] as int),
        arguments: [playListId],
        queryableName: PlaylistDetailEntity.tableName,
        isView: false);
  }

//using unit test
  Future<List<StreamData>> getStreamData(int playListId) {
    return _queryAdapter.queryList(sqlQueryStreams,
        mapper: (Map<String, Object?> row) => StreamData(
            StreamEntity(
                row['uid'] as String,
                row['url'] as String,
                row['tile'] as String,
                row['streamType'] as String,
                row['duration'] as int,
                row['uploader'] as String,
                row['uploaderUrl'] as String,
                row['viewCount'] as int,
                row['textualUploadDate'] as String,
                row['uploadDate'] as int),
            row['progressTime'] as int,
            row['joinIndex'] as int),
        arguments: [playListId]);
  }

  @transaction
  Future<void> createPlaylist(String name, String streamId) async {
    var streamState = await historyDao.firstOrNullStreamState(streamId);
    if (streamState == null) {
      await historyDao.insertStreamStateEntity(
        StreamStateEntity(streamId, 0),
      );
    }

    PlaylistEntity entity = PlaylistEntity(null, name);
    var playListId = await playListDao.addPlaylist(entity);

    await detailsDao.insert(
      PlaylistDetailEntity(
          playlistId: playListId, streamId: streamId, joinIndex: maxIntValue),
    );
  }

  Future<void> addStreamToPlayList(int playId, String streamId) async {
    var streamState = await historyDao.firstOrNullStreamState(streamId);
    if (streamState == null) {
      await historyDao.insertStreamStateEntity(StreamStateEntity(streamId, 0));
    }

    await detailsDao.insert(
      PlaylistDetailEntity(
          playlistId: playId, streamId: streamId, joinIndex: maxIntValue),
    );
  }

  Future<void> deletePlayList(int playListId) async {
    await playListDao.deletePlayListByID(playListId).then(
          (value) => appDatabase.notifyTableChanged(PlaylistEntity.tableName),
        );

    await detailsDao.deleteByPLayListId(playListId).then(
          (value) =>
              appDatabase.notifyTableChanged(PlaylistDetailEntity.tableName),
        );
  }

  Stream<List<PlaylistEntity>> findAllPlayListAsStream() {
    return playListDao.findAllAsStream();
  }

  Future<List<PlaylistEntity>> findAllPlayList() async {
    return playListDao.findAll();
  }

  Future<List<PlaylistDetailEntity>> findAllPlayListDetail() async {
    return detailsDao.findAllDetails();
  }

  Stream<List<StreamData>> getListStreamFromPlayList(int playListId) {
    return _getStreamDataFromPlayList(playListId);
  }

  @transaction
  Future<void> reorderListStream(int playListId, List<StreamData> items) async {
    await detailsDao.clearDetailsById(playListId);

    var newItems = items.map(
      (item) => PlaylistDetailEntity(
        playlistId: playListId,
        streamId: item.streamEntity.uid,
        joinIndex: items.indexOf(item),
      ),
    );
    await detailsDao.insertEntities(newItems.toList());
  }

  Future<void> removeStreamFromPLayList(int playListId, String streamId) {
    return detailsDao.deleteStreamFromPlayList(playListId, streamId)
        .then(
          (value) =>
              appDatabase.notifyTableChanged(PlaylistDetailEntity.tableName),
        );
  }

  Future<void> updateNamePlayList(String playListName, int playListId) {
    return playListDao
        .renamePlayList(PlaylistEntity(playListId, playListName))
        .then(
          (value) =>
              appDatabase.notifyTableChanged(PlaylistDetailEntity.tableName),
        );
  }
}
