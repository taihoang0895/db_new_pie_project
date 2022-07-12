import 'package:db_new_pie_project/database/entities/history/stream_history_entity.dart';
import 'package:db_new_pie_project/database/entities/history/stream_state_entity.dart';
import 'package:floor/floor.dart';

import '../../app_database.dart';
import '../../entities/stream/stream_entity.dart';
import '../stream/stream_history.dart';

class HistoryManager {
  final AppDatabase _appDatabase;
  final QueryAdapter _queryAdapter;


  HistoryManager(this._appDatabase) : _queryAdapter = _appDatabase.buildQueryAdapter();

  Stream<List<StreamHistory>> findAllStreamHistoryAsStream(){
    String sql = 'SELECT * FROM (SELECT ${StreamHistoryEntity.tableName}.*, ${StreamEntity.tableName}.* FROM ${StreamHistoryEntity.tableName} INNER JOIN ${StreamEntity.tableName} ON ${StreamHistoryEntity.tableName}.streamId = ${StreamEntity.tableName}.uid) as stream_records'
        ' INNER JOIN ${StreamStateEntity.tableName} ON ${StreamStateEntity.tableName}.streamId = stream_records.streamId ORDER BY stream_records.accessDate DESC';

    return _queryAdapter.queryListStream(sql,
        mapper: (Map<String, Object?> row) => StreamHistory(
            row['progressTime'] as int,
            StreamHistoryEntity(
              row['streamId'] as int,
              row['accessDate'] as int,
              row['repeatCount'] as int,
            ),
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
              row['uploadDate'] as int,
            )

        ),
        queryableName: StreamHistoryEntity.tableName,
        isView: false);
  }

  Future<List<StreamHistoryEntity>> findAllHistoryEntities() {
    return _appDatabase.historyDao.findAllStreamHistoryEntities();
  }

  Future<void> delete(int id) {
    return _appDatabase.historyDao.deleteStreamHistory(id).then((value) => _appDatabase.notifyTableChanged(StreamHistoryEntity.tableName));
  }

  Future<void> clear() {
    return _appDatabase.historyDao.clearStreamHistory().then((value) => _appDatabase.notifyTableChanged(StreamHistoryEntity.tableName));
  }

  Stream<List<StreamHistoryEntity>> findAllHistoryEntitiesAsStream() {
    return _appDatabase.historyDao.findAllStreamHistoryEntitiesAsStream();
  }

  Future<void> save(int streamId) {
    return _appDatabase.historyDao
        .firstOrNullStreamHistory(streamId)
        .then((streamHistory) {
      if (streamHistory == null) {
        _appDatabase.historyDao.insertStreamHistory(StreamHistoryEntity(
            streamId, DateTime.now().millisecondsSinceEpoch, 0)).then((value){
          _appDatabase.historyDao.insertStreamStateEntity(StreamStateEntity(streamId, 0));
        });
      } else {
        streamHistory.accessDate = DateTime.now().millisecondsSinceEpoch;
        _appDatabase.historyDao.updateStreamHistory(streamHistory);
      }
    });
  }

  Future<void> updateProgressTime(int streamId, int time) {
    return _appDatabase.historyDao.firstOrNullStreamState(streamId).then((entity){
        if(entity == null){
          _appDatabase.historyDao.insertStreamStateEntity(StreamStateEntity(streamId, time));
        }else{
          entity.progressTime = time;
          _appDatabase.historyDao.updateStreamStateEntity(entity);
        }
    }).then((value) => _appDatabase.notifyTableChanged(StreamHistoryEntity.tableName));
  }

  Future<StreamStateEntity?> firstOrNullStreamState(int streamId){
    return _appDatabase.historyDao.firstOrNullStreamState(streamId);
  }

  Future<void> increaseViewCount(int streamId) {
    return _appDatabase.historyDao.firstOrNullStreamHistory(streamId).then((entity){
        if(entity == null){
          _appDatabase.historyDao.insertStreamHistory(StreamHistoryEntity(streamId, DateTime.now().millisecondsSinceEpoch, 1));
        }else{
          entity.repeatCount += 1;
          entity.accessDate = DateTime.now().millisecondsSinceEpoch;
          _appDatabase.historyDao.updateStreamHistory(entity);
        }
    });
  }
}
