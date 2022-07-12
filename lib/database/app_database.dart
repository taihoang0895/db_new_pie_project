import 'dart:async';

import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:floor/floor.dart';

import 'entities/entities.dart';
import 'dao/dao.dart';
part 'app_database.g.dart';


@Database(version: 1, entities: [SearchHistoryEntity, StreamEntity, StreamHistoryEntity, StreamStateEntity, SubscriptionEntity, PlaylistEntity,PlaylistDetailEntity])
abstract class AppDatabase extends FloorDatabase {
  HistoryDao get historyDao;
  StreamDao get streamDao;
  SubscriptionDao get subscriptionDao;
  PlaylistDao get playListDao;
  PlayListDetailsDao get detailsDao;
  SearchHistoryDao get searchHistoryDao;

  QueryAdapter buildQueryAdapter(){
      return QueryAdapter(database, changeListener);
  }

  void notifyTableChanged(String tableName){
    changeListener.add(tableName);


  }
}
