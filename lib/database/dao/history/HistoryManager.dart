import 'package:db_new_pie_project/database/entities/history/StreamHistoryEntity.dart';
import 'package:db_new_pie_project/database/entities/history/StreamStateEntity.dart';

import '../../app_database.dart';
import '../../entities/stream/StreamEntity.dart';
import '../stream/StreamHistory.dart';

class HistoryManager {
  final AppDatabase _appDatabase;

  /*Stream<List<StreamHistory>> get streamHistories =>
      _appDatabase.historyDao.watchAllStreamHistory();*/

  HistoryManager(this._appDatabase);

  Future<List<StreamHistoryEntity>> findAllHistoryEntities() {
    return _appDatabase.historyDao.findAllStreamHistoryEntities();
  }

  Future<void> delete(int id) {
    return _appDatabase.historyDao.deleteStreamHistory(id).then((value) => _appDatabase.notifyTableChanged(StreamHistoryEntity.TABLE_NAME));
  }

  Future<void> clear() {
    return _appDatabase.historyDao.clearStreamHistory().then((value) => _appDatabase.notifyTableChanged(StreamHistoryEntity.TABLE_NAME));
  }

  Stream<List<StreamHistoryEntity>> findAllHistoryEntitiesAsStream(
      {int limit = 30}) {
    return _appDatabase.historyDao.watchStreamHistoryEntities(limit);
  }

  Future<void> save(int streamId) {
    return _appDatabase.historyDao
        .firstOrNullStreamHistory(streamId)
        .then((streamHistory) {
      if (streamHistory == null) {
        _appDatabase.historyDao.insertStreamHistory(StreamHistoryEntity(
            streamId, DateTime.now().millisecondsSinceEpoch, 0));
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
    }).then((value) => _appDatabase.notifyTableChanged(StreamHistoryEntity.TABLE_NAME));
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
