import 'package:db_new_pie_project/database/entities/history/stream_history_entity.dart';
import 'package:db_new_pie_project/database/entities/history/stream_state_entity.dart';
import 'package:db_new_pie_project/database/entities/playlist/play_list_detail_entity.dart';
import 'package:floor/floor.dart';

import '../app_database.dart';
import '../entities/stream/stream_entity.dart';
import '../dao/stream/stream_history.dart';

class HistoryManager {
  final AppDatabase _appDatabase;
  final QueryAdapter _queryAdapter;

  HistoryManager(this._appDatabase)
      : _queryAdapter = _appDatabase.buildQueryAdapter();

  /**
   * Get all streams which are watched before
   */
  Stream<List<StreamHistory>> findAllAsStream() {
    String sql = """
    SELECT *
    FROM
      (SELECT ${StreamHistoryEntity.tableName}.*, ${StreamEntity.tableName}.*
       FROM ${StreamHistoryEntity.tableName}
       INNER JOIN ${StreamEntity.tableName} ON ${StreamHistoryEntity.tableName}.streamId = ${StreamEntity.tableName}.uid) AS stream_records
    INNER JOIN ${StreamStateEntity.tableName} ON ${StreamStateEntity.tableName}.streamId = stream_records.streamId
    ORDER BY stream_records.accessDate DESC
    """;
    return _queryAdapter.queryListStream(sql,
        mapper: (Map<String, Object?> row) => StreamHistory(
            row['progressTime'] as int,
            StreamHistoryEntity(
              row['streamId'] as String,
              row['accessDate'] as int,
              row['repeatCount'] as int,
            ),
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
              row['uploadDate'] as int,
            )),
        queryableName: StreamHistoryEntity.tableName,
        isView: false);
  }

  /**
   * Get all history entities as stream which are watched before
   */
  Stream<List<StreamHistoryEntity>> findAllHistoryEntitiesAsStream() {
    return _appDatabase.historyDao.findAllStreamHistoryEntitiesAsStream();
  }

  /**
   * Get all history entities which are watched before
   */
  Future<List<StreamHistoryEntity>> findAllHistoryEntities() {
    return _appDatabase.historyDao.findAllStreamHistoryEntities();
  }

  /**
   * @Param id : Stream Id
   * Remove a stream out of histories
   */
  Future<void> delete(String id) {
    return _appDatabase.historyDao.deleteStreamHistory(id).then(
          (_) => _appDatabase.notifyTableChanged(StreamHistoryEntity.tableName),
        );
  }

  Future<int?> getProgressTime(String id) {
    return _appDatabase.historyDao
        .findStreamStateById(id)
        .then((value) => value?.progressTime);
  }

  /**
   * Remove all stream histories
   */
  Future<void> clear() {
    return _appDatabase.historyDao.clear().then(
        (_) => _appDatabase.notifyTableChanged(StreamHistoryEntity.tableName));
  }

  /**
   * @Param streamId : Stream Id
   * Performing insert action if the stream id has never watched before else performing update action
   */

  @transaction
  Future<void> save(String streamId) async {
    var streamHistory =
        await _appDatabase.historyDao.firstOrNullStreamHistory(streamId);
    var streamState =
        await _appDatabase.historyDao.firstOrNullStreamState(streamId);

    if (streamState == null) {
      _appDatabase.historyDao
          .insertStreamStateEntity(StreamStateEntity(streamId, 0));
    }

    if (streamHistory == null) {
      await _appDatabase.historyDao.insertStreamHistory(StreamHistoryEntity(
          streamId, DateTime.now().millisecondsSinceEpoch, 0));
    } else {
      streamHistory.accessDate = DateTime.now().millisecondsSinceEpoch;
      await _appDatabase.historyDao.updateStreamHistory(streamHistory);
    }
  }

  /**
   * @Param streamId : Stream Id
   * @Param  time : How long a user has watched a stream
   * Update progress time of a stream
   */
  Future<void> updateProgressTime(String streamId, int time) {
    return _appDatabase.historyDao
        .insertStreamStateEntity(StreamStateEntity(streamId, time))
        .then(
      (_) {
        _appDatabase.notifyTableChanged(StreamHistoryEntity.tableName);
        _appDatabase.notifyTableChanged(PlaylistDetailEntity.tableName);
      },
    );
  }

  Future<StreamStateEntity?> firstOrNullStreamState(String streamId) {
    return _appDatabase.historyDao.firstOrNullStreamState(streamId);
  }

  Future<void> increaseViewCount(String streamId) {
    return _appDatabase.historyDao.firstOrNullStreamHistory(streamId).then(
      (entity) {
        if (entity == null) {
          _appDatabase.historyDao.insertStreamHistory(
            StreamHistoryEntity(
                streamId, DateTime.now().millisecondsSinceEpoch, 1),
          );
        } else {
          entity.repeatCount += 1;
          entity.accessDate = DateTime.now().millisecondsSinceEpoch;
          _appDatabase.historyDao.updateStreamHistory(entity);
        }
      },
    );
  }
}
