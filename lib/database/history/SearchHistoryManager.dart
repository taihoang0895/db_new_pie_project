import 'package:db_new_pie_project/database/entities/history/SearchHistoryEntity.dart';

abstract class SearchHistoryManager{
  Future<bool> insert(String text);
  Future<void> delete(int id);
  Future<List<SearchHistoryEntity>> findSimilarText(String text);
}