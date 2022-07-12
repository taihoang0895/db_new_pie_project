
import 'package:floor/floor.dart';

import '../../entities/history/stream_history_entity.dart';
import '../../entities/history/stream_state_entity.dart';
import 'package:db_new_pie_project/database/entities/history/search_history_entity.dart';

@dao
abstract class SearchHistoryDao{
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertSearchHistory(SearchHistoryEntity entity);

  @update
  Future<void> updateSearchHistory(SearchHistoryEntity entity);

  @Query('SELECT * FROM ${SearchHistoryEntity.tableName} order by creationDate DESC')
  Future<List<SearchHistoryEntity>> findAll();

  @Query('SELECT * FROM ${SearchHistoryEntity.tableName} order by creationDate DESC')
  Stream<List<SearchHistoryEntity>> findAllAsStream();

  @Query('DELETE FROM ${SearchHistoryEntity.tableName}')
  Future<void> clearSearchHistory();

  @Query('DELETE FROM ${SearchHistoryEntity.tableName} WHERE id = :id')
  Future<void> deleteSearchHistory(int id);

  @Query('SELECT *  FROM ${SearchHistoryEntity.tableName} WHERE search = :text LIMIT 1')
  Future<SearchHistoryEntity?> firstOrNull(String text);

  @Query("SELECT *  FROM ${SearchHistoryEntity.tableName} WHERE search LIKE :text || '%' order by creationDate DESC LIMIT :limit")
  Stream<List<SearchHistoryEntity>> findSimilarText(String text, int limit);

  @Query('SELECT * FROM ${StreamHistoryEntity.tableName} WHERE streamId = :streamId LIMIT 1')
  Future<StreamHistoryEntity?> firstOrNullStreamHistory(int streamId);

  @Query('SELECT * FROM ${StreamHistoryEntity.tableName} ORDER BY accessDate DESC')
  Future<List<StreamHistoryEntity>> findAllStreamHistoryEntities();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertStreamHistory(StreamHistoryEntity entity);

  @Update(onConflict:OnConflictStrategy.replace)
  Future<void> updateStreamHistory(StreamHistoryEntity entity);

  @Query("SELECT * FROM ${StreamHistoryEntity.tableName} order by accessDate DESC")
  Stream<List<StreamHistoryEntity>> findAllStreamHistoryEntitiesAsStream();

  @Query('DELETE FROM ${StreamHistoryEntity.tableName} WHERE streamId = :id')
  Future<void> deleteStreamHistory(int id);

  @Query('DELETE FROM ${StreamHistoryEntity.tableName}')
  Future<void> clearStreamHistory();

  @insert
  Future<void> insertStreamStateEntity(StreamStateEntity entity);

  @update
  Future<void> updateStreamStateEntity(StreamStateEntity entity);

  @Query('SELECT * FROM ${StreamStateEntity.tableName} WHERE streamId = :streamId')
  Future<StreamStateEntity?> firstOrNullStreamState(int streamId);

}