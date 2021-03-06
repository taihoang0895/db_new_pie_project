import 'package:db_new_pie_project/database/app_database.dart';
import 'package:db_new_pie_project/database/entities/history/SearchHistoryEntity.dart';

import 'HistoryDao.dart';

class SearchHistoryManager {
  final AppDatabase _appDatabase;

  SearchHistoryManager(this._appDatabase);

  Future<void> onSearched(String text) {
    final SearchHistoryDao searchHistoryDao = _appDatabase.historyDao;

    return searchHistoryDao.firstOrNull(text).then((record) {
      if (record == null) {
        SearchHistoryEntity entity = SearchHistoryEntity(
            null, text, DateTime.now().millisecondsSinceEpoch);
        searchHistoryDao.insertSearchHistory(entity);
      } else {
        record.creationDate = DateTime.now().millisecondsSinceEpoch;
        searchHistoryDao.updateSearchHistory(record);
      }
    });
  }

  Future<void> delete(int id) {
    final SearchHistoryDao searchHistoryDao = _appDatabase.historyDao;
    return searchHistoryDao.deleteSearchHistory(id).then((value) => _appDatabase.notifyTableChanged(SearchHistoryEntity.TABLE_NAME));
  }

  Stream<List<SearchHistoryEntity>> findSimilarText(String text) {
    if (text.trim().isEmpty) {
      return _appDatabase.historyDao.findAllAsStream();
    } else {
      final SearchHistoryDao searchHistoryDao = _appDatabase.historyDao;
      return searchHistoryDao.findSimilarText(text);
    }
  }

  Future<void> clear() {
    final SearchHistoryDao searchHistoryDao = _appDatabase.historyDao;
    return searchHistoryDao.clearSearchHistory().then((value) => _appDatabase.notifyTableChanged(SearchHistoryEntity.TABLE_NAME));
  }

  Future<List<SearchHistoryEntity>> findAll() {
    final SearchHistoryDao searchHistoryDao = _appDatabase.historyDao;
    return searchHistoryDao.findAll();
  }
}
