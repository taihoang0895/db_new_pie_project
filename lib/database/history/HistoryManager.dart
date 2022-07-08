
import '../entities/StreamEntity.dart';
import 'StreamHistory.dart';

abstract class HistoryManager{
  Stream<StreamHistory> findAll();
  Future<bool> delete(int id);
  Future<bool> clear();
  Future<bool> insert(StreamEntity streamEntity);
  Future<void> uploadProgressTime(int streamId, int time);
  Future<void> increaseViewCount();
}