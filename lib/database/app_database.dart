import 'dart:async';
import 'package:db_new_pie_project/database/dao/subscription/SubscriptionDao.dart';
import 'package:db_new_pie_project/database/dao/subscription/SubscriptionDetailDao.dart';
import 'package:db_new_pie_project/database/entities/history/SearchHistoryEntity.dart';
import 'package:db_new_pie_project/database/entities/stream/StreamEntity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:floor/floor.dart';

import 'dao/history/HistoryDao.dart';
import 'dao/stream/StreamDao.dart';
import 'dao/subscription/SubscriptionGroupDao.dart';
import 'entities/history/StreamHistoryEntity.dart';
import 'entities/history/StreamStateEntity.dart';
import 'entities/subscription/SubscriptionDetailEntity.dart';
import 'entities/subscription/SubscriptionEntity.dart';
import 'entities/subscription/SubscriptionGroupEntity.dart';
part 'app_database.g.dart';

@Database(version: 1, entities: [SearchHistoryEntity, StreamEntity, StreamHistoryEntity, StreamStateEntity, SubscriptionEntity, SubscriptionGroupEntity, SubscriptionDetailEntity])
abstract class AppDatabase extends FloorDatabase {
  SearchHistoryDao get historyDao;
  StreamDao get streamDao;
  SubscriptionDao get subscriptionDao;
  SubscriptionDetailDao get subscriptionDetailDao;
  SubscriptionGroupDao get subscriptionGroupDao;

  QueryAdapter buildQueryAdapter(){
      return QueryAdapter(database, changeListener);
  }

  void notifyTableChanged(String tableName){
    changeListener.add(tableName);


  }
}
