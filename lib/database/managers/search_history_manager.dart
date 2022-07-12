import 'package:db_new_pie_project/database/app_database.dart';
import 'package:db_new_pie_project/database/dao/history/search_history_dao.dart';
import 'package:db_new_pie_project/database/entities/history/search_history_entity.dart';

import '../dao/history/history_dao.dart';

class SearchHistoryManager {
  final AppDatabase _appDatabase;

  SearchHistoryManager(this._appDatabase);

  /**
   * @Param text : is a keyword which user typed.
   * Store a list of keyword which user typed before
   */
  Future<void> onSearched(String text) {
    final SearchHistoryDao searchHistoryDao = _appDatabase.searchHistoryDao;
    SearchHistoryEntity entity =
        SearchHistoryEntity(text, DateTime.now().millisecondsSinceEpoch);
    return searchHistoryDao.insertSearchHistory(entity);
  }

  /**
   * @Param id : id of keyword which saved in database
   * Remove a keyword which saved before
   */
  Future<void> delete(String text) {
    final SearchHistoryDao searchHistoryDao = _appDatabase.searchHistoryDao;
    return searchHistoryDao.deleteSearchHistory(text);
  }

  /**
   * @Param text : is a keyword which user typed
   * Find list of keyword which are similar with text input as the user types
   */

  Future<List<SearchHistoryEntity>> findSimilarText(String text,
      {int limit = 30}) {
    if (text.trim().isEmpty) {
      return _appDatabase.searchHistoryDao.findAll();
    } else {
      final SearchHistoryDao searchHistoryDao = _appDatabase.searchHistoryDao;
      return searchHistoryDao.findSimilarText(text, limit);
    }
  }

  Future<void> clear() {
    final SearchHistoryDao searchHistoryDao = _appDatabase.searchHistoryDao;
    return searchHistoryDao.clearSearchHistory();
  }

  Future<List<SearchHistoryEntity>> findAll() {
    final SearchHistoryDao searchHistoryDao = _appDatabase.searchHistoryDao;
    return searchHistoryDao.findAll();
  }
}
