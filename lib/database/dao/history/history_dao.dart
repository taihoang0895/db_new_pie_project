import 'package:floor/floor.dart';

import '../../entities/history/stream_history_entity.dart';
import '../../entities/history/stream_state_entity.dart';
import 'package:db_new_pie_project/database/entities/history/search_history_entity.dart';

@dao
abstract class HistoryDao {
  @Query(
      'SELECT * FROM ${StreamHistoryEntity.tableName} WHERE streamId = :streamId LIMIT 1')
  Future<StreamHistoryEntity?> firstOrNullStreamHistory(String streamId);

  @Query(
      'SELECT * FROM ${StreamHistoryEntity.tableName} ORDER BY accessDate DESC')
  Future<List<StreamHistoryEntity>> findAllStreamHistoryEntities();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertStreamHistory(StreamHistoryEntity entity);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateStreamHistory(StreamHistoryEntity entity);

  @Query(
      "SELECT * FROM ${StreamHistoryEntity.tableName} order by accessDate DESC")
  Stream<List<StreamHistoryEntity>> findAllStreamHistoryEntitiesAsStream();

  @Query('DELETE FROM ${StreamHistoryEntity.tableName} WHERE streamId = :id')
  Future<void> deleteStreamHistory(String id);

  @Query('DELETE FROM ${StreamHistoryEntity.tableName}')
  Future<void> clear();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertStreamStateEntity(StreamStateEntity entity);

  @Query(
      'SELECT * FROM ${StreamStateEntity.tableName} WHERE streamId = :streamId')
  Future<StreamStateEntity?> firstOrNullStreamState(String streamId);

  @Query(
      'SELECT * FROM ${StreamStateEntity.tableName} WHERE streamId = :streamId')
  Future<StreamStateEntity?> findStreamStateById(String streamId);

  @Query('DELETE FROM ${StreamStateEntity.tableName}')
  Future<void> clearStreamState();
}
