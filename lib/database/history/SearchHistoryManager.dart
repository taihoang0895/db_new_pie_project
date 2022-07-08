import 'package:db_new_pie_project/database/app_database.dart';
import 'package:db_new_pie_project/database/entities/history/SearchHistoryEntity.dart';

import '../dao/history/SearchHistoryDao.dart';

class SearchHistoryManager {
  final AppDatabase _appDatabase;

  SearchHistoryManager(this._appDatabase);

  Future<void> insert(String text) async {
    final SearchHistoryDao searchHistoryDao = _appDatabase.searchHistoryDao;
    bool existed = await searchHistoryDao.existSearchText(text);
    if(!existed){
      SearchHistoryEntity entity =
      SearchHistoryEntity(null, text, DateTime.now().millisecond);
      return searchHistoryDao.insertSearchHistory(entity);
    }
  }

  Future<void> delete(int id) {
    final SearchHistoryDao searchHistoryDao = _appDatabase.searchHistoryDao;
    return searchHistoryDao.delete(id);
  }

  Future<List<SearchHistoryEntity>> findSimilarText(String text) {
    throw Exception("fdfd");
  }
  Future<void> clear(){
    final SearchHistoryDao searchHistoryDao = _appDatabase.searchHistoryDao;
    return searchHistoryDao.clear();
  }

  Future<List<SearchHistoryEntity>> findAll() {
    final SearchHistoryDao searchHistoryDao = _appDatabase.searchHistoryDao;
    return searchHistoryDao.findAll();
  }


}
