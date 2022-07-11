
import 'package:db_new_pie_project/database/entities/history/SearchHistoryEntity.dart';
import 'package:floor/floor.dart';

import '../../entities/history/StreamHistoryEntity.dart';
import '../../entities/history/StreamStateEntity.dart';
import '../stream/StreamHistory.dart';

@dao
abstract class SearchHistoryDao{
  @insert
  Future<void> insertSearchHistory(SearchHistoryEntity entity);

  @update
  Future<void> updateSearchHistory(SearchHistoryEntity entity);

  @Query('SELECT * FROM ${SearchHistoryEntity.TABLE_NAME} order by creationDate DESC')
  Future<List<SearchHistoryEntity>> findAll();

  @Query('SELECT * FROM ${SearchHistoryEntity.TABLE_NAME} order by creationDate DESC')
  Stream<List<SearchHistoryEntity>> findAllAsStream();

  @Query('DELETE FROM ${SearchHistoryEntity.TABLE_NAME}')
  Future<void> clearSearchHistory();

  @Query('DELETE FROM ${SearchHistoryEntity.TABLE_NAME} WHERE id = :id')
  Future<void> deleteSearchHistory(int id);

  @Query('SELECT *  FROM ${SearchHistoryEntity.TABLE_NAME} WHERE search = :text LIMIT 1')
  Future<SearchHistoryEntity?> firstOrNull(String text);

  @Query("SELECT *  FROM ${SearchHistoryEntity.TABLE_NAME} WHERE search LIKE :text || '%' order by creationDate DESC LIMIT :limit")
  Stream<List<SearchHistoryEntity>> findSimilarText(String text, int limit);

  /*@Query('SELECT * FROM ${StreamHistoryEntity.TABLE_NAME}')
  Stream<List<StreamHistory>> watchAllStreamHistory();*/

  @Query('SELECT * FROM ${StreamHistoryEntity.TABLE_NAME} WHERE streamId = :streamId LIMIT 1')
  Future<StreamHistoryEntity?> firstOrNullStreamHistory(int streamId);

  @Query('SELECT * FROM ${StreamHistoryEntity.TABLE_NAME} ORDER BY accessDate DESC')
  Future<List<StreamHistoryEntity>> findAllStreamHistoryEntities();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertStreamHistory(StreamHistoryEntity entity);

  @Update(onConflict:OnConflictStrategy.replace)
  Future<void> updateStreamHistory(StreamHistoryEntity entity);

  @Query("SELECT * FROM ${StreamHistoryEntity.TABLE_NAME} order by accessDate DESC LIMIT :limit")
  Stream<List<StreamHistoryEntity>> watchStreamHistoryEntities(int limit);

  @Query('DELETE FROM ${StreamHistoryEntity.TABLE_NAME} WHERE streamId = :id')
  Future<void> deleteStreamHistory(int id);

  @Query('DELETE FROM ${StreamHistoryEntity.TABLE_NAME}')
  Future<void> clearStreamHistory();

  @insert
  Future<void> insertStreamStateEntity(StreamStateEntity entity);

  @update
  Future<void> updateStreamStateEntity(StreamStateEntity entity);

  @Query('SELECT * FROM ${StreamStateEntity.TABLE_NAME} WHERE streamId = :streamId')
  Future<StreamStateEntity?> firstOrNullStreamState(int streamId);

}