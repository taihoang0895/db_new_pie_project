import 'package:floor/floor.dart';

import '../../entities/history/search_history_entity.dart';

@dao
abstract class SearchHistoryDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertSearchHistory(SearchHistoryEntity entity);

  @update
  Future<void> updateSearchHistory(SearchHistoryEntity entity);

  @Query(
      'SELECT * FROM ${SearchHistoryEntity.tableName} order by creationDate DESC')
  Future<List<SearchHistoryEntity>> findAll();

  @Query('DELETE FROM ${SearchHistoryEntity.tableName}')
  Future<void> clear();

  @Query('DELETE FROM ${SearchHistoryEntity.tableName} WHERE search = :text')
  Future<void> deleteSearchHistory(String text);

  @Query(
      'SELECT *  FROM ${SearchHistoryEntity.tableName} WHERE search = :text LIMIT 1')
  Future<SearchHistoryEntity?> firstOrNull(String text);

  @Query(
      "SELECT *  FROM ${SearchHistoryEntity.tableName} WHERE search LIKE :text || '%' order by creationDate DESC LIMIT :limit")
  Future<List<SearchHistoryEntity>> findSimilarText(String text, int limit);
}
