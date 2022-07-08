
import 'package:db_new_pie_project/database/entities/history/SearchHistoryEntity.dart';
import 'package:floor/floor.dart';

@dao
abstract class SearchHistoryDao{
  @insert
  Future<void> insertSearchHistory(SearchHistoryEntity entity);

  @Query('SELECT * FROM ${SearchHistoryEntity.TABLE_NAME}')
  Future<List<SearchHistoryEntity>> findAll();

  @Query('DELETE FROM SearchHistory')
  Future<void> clear();

  @Query('DELETE FROM SearchHistory WHERE id = :id')
  Future<void> delete(int id);

  @Query('SELECT COUNT(*) > 0 FROM SearchHistory WHERE text = :text')
  Future<bool> existSearchText(String text);

  @Query('SELECT COUNT(*) > 0 FROM SearchHistory WHERE text = :text')
  Future<List<SearchHistoryEntity>>getSimilarEntries(String query);



}