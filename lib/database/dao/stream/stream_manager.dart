import '../../app_database.dart';
import '../../entities/stream/stream_entity.dart';
import '../stream/stream_history.dart';

class StreamManager {
  final AppDatabase _appDatabase;

  StreamManager(this._appDatabase);

  Future<void> clear() {
    return _appDatabase.streamDao.clear();
  }

  Stream<List<StreamEntity>> findAllAsStream() =>
      _appDatabase.streamDao.findAllAsStream();

  Future<void> insert(StreamEntity entity) {
    return _appDatabase.streamDao.insertStream(entity);
  }

  Future<void> insertEntities(List<StreamEntity> entites) {
    return _appDatabase.streamDao.insertStreams(entites);
  }

  Future<void> deleteById(String id) {
    var result = _appDatabase.streamDao.deleteStreamById(id);
    result.then(
        (value) => _appDatabase.notifyTableChanged(StreamEntity.tableName));
    return result;
  }

  Stream<StreamEntity?> findFirstOrNull(String id) {
    return _appDatabase.streamDao.findByIdAsStream(id);
  }

  Future<void> delete(StreamEntity entity) {
    return _appDatabase.streamDao.deleteStream(entity);
  }

  Future<void> update(StreamEntity entity) {
    return _appDatabase.streamDao.updateStream(entity);
  }

  Future<List<StreamEntity>> findAll() {
    return _appDatabase.streamDao.findAll();
  }
}
