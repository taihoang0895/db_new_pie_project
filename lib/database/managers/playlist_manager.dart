import 'dart:async';

import 'package:db_new_pie_project/database/dao/stream/stream_dao.dart';
import 'package:db_new_pie_project/database/entities/entities.dart';
import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';

import '../app_database.dart';
import '../dao/history/search_history_dao.dart';
import '../entities/playlist/play_list_data.dart';
import '../entities/playlist/play_list_entity.dart';
import '../entities/playlist/play_list_detail_entity.dart';
import '../entities/stream/stream_entity.dart';
import '../dao/history/history_dao.dart';
import '../dao/playlist/play_list_dao.dart';
import '../dao/playlist/play_list_details_dao.dart';

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

  Future<void> createPlaylist(String name, String streamId) async {
    var playListAll = await playListDao.findAll();

    var streamState = await historyDao.firstOrNullStreamState(streamId);
    if (streamState == null) {
      await historyDao.insertStreamStateEntity(
        StreamStateEntity(streamId, 0),
      );
    }
    var isExist = playListAll.map((e) => e.name).contains(name);
    if (!isExist) {
      var lateId = 0;
      for (var element in playListAll) {
        if (lateId <= element.id) {
          lateId = element.id;
        }
      }

      var detailsAll = await detailsDao.findAll();

      PlaylistEntity entity = PlaylistEntity(lateId + 1, name);
      await playListDao.addPlaylist(entity);

      await detailsDao.addPlaylistDetail(PlaylistDetailEntity(
          playlistId: entity.id,
          streamId: streamId,
          joinIndex: _findMaxIndex(detailsAll) + 1));
    }
  }

  Future<void> addStreamToPlayList(int playId, String streamId) async {
    var data = await detailsDao.findAll();

    var streamState = await historyDao.firstOrNullStreamState(streamId);
    if (streamState == null) {
      await historyDao.insertStreamStateEntity(StreamStateEntity(streamId, 0));
    }

    await detailsDao.addPlaylistDetail(PlaylistDetailEntity(
        playlistId: playId,
        streamId: streamId,
        joinIndex: _findMaxIndex(data) + 1));
  }

  Future<void> deletePlayList(int playListId) async {
    await playListDao.deletePlayListByID(playListId).then(
          (value) => appDatabase.notifyTableChanged(PlaylistEntity.tableName),
        );

    await detailsDao.deletePlayListDetailById(playListId).then(
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
    return detailsDao.findAll();
  }

  Stream<List<StreamData>> getListStreamFromPlayList(int playListId) {
    return _getStreamDataFromPlayList(playListId);
  }

  Future<void> reorderListStream(int playlistId, List<StreamData> items) async {
    await detailsDao.clearDetails();

    for (StreamData item in items) {
      var detailItem = PlaylistDetailEntity.clone(
        PlaylistDetailEntity(
          playlistId: playlistId,
          streamId: item.streamEntity.uid,
          joinIndex: items.indexOf(item),
        ),
      );

      detailsDao.addPlaylistDetail(detailItem);
    }
  }

  Future<void> removeStreamFromPLayList(int playListId, String streamId) async {
    await detailsDao.deleteStreamFromPlayList(playListId, streamId);
  }

  Future<void> updateNamePlayList(String playListName, int playListId) async {
    await playListDao.renamePlayList(PlaylistEntity(playListId, playListName));
  }

  int _findMaxIndex(List<PlaylistDetailEntity> items) {
    var max = 0;
    for (var element in items) {
      if (max <= element.joinIndex) {
        max = element.joinIndex;
      }
    }
    return max;
  }
}
