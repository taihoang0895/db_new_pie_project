import 'dart:async';
import 'package:db_new_pie_project/database/dao/subscription/subscription_dao.dart';
import 'package:db_new_pie_project/database/dao/subscription/subscription_detail_dao.dart';
import 'package:db_new_pie_project/database/entities/stream/stream_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:floor/floor.dart';

import 'dao/history/history_dao.dart';
import 'dao/playlist/play_list_dao.dart';
import 'dao/playlist/play_list_details_dao.dart';
import 'dao/stream/stream_dao.dart';
import 'dao/subscription/subscription_group_dao.dart';
import 'entities/entities.dart';
import 'entities/playlist/play_list_entity.dart';
import 'entities/playlist/play_list_detail_entity.dart';
import 'entities/subscription/subscription_detail_entity.dart';
import 'entities/subscription/subscription_entity.dart';
import 'entities/subscription/subscription_group_entity.dart';
part 'app_database.g.dart';


@Database(version: 1, entities: [SearchHistoryEntity, StreamEntity, StreamHistoryEntity, StreamStateEntity, SubscriptionEntity, SubscriptionGroupEntity, SubscriptionDetailEntity, PlaylistEntity,PlaylistDetailEntity])
abstract class AppDatabase extends FloorDatabase {
  SearchHistoryDao get historyDao;
  StreamDao get streamDao;
  SubscriptionDao get subscriptionDao;
  SubscriptionDetailDao get subscriptionDetailDao;
  SubscriptionGroupDao get subscriptionGroupDao;
  PlaylistDao get playListDao;
  PlayListDetailsDao get detailsDao;

  QueryAdapter buildQueryAdapter(){
      return QueryAdapter(database, changeListener);
  }

  void notifyTableChanged(String tableName){
    changeListener.add(tableName);


  }
}
