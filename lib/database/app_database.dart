import 'dart:async';
import 'package:db_new_pie_project/database/entities/history/SearchHistoryEntity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:floor/floor.dart';

import 'dao/history/SearchHistoryDao.dart';
part 'app_database.g.dart';

@Database(version: 1, entities: [SearchHistoryEntity])
abstract class AppDatabase extends FloorDatabase {
  SearchHistoryDao get searchHistoryDao;
}
