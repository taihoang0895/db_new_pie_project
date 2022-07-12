import 'package:floor/floor.dart';

@Entity(tableName: SearchHistoryEntity.tableName)
class SearchHistoryEntity {
  @primaryKey
  String search;
  int creationDate;

  SearchHistoryEntity(this.search, this.creationDate);

  static const String tableName = "SearchHistory";
}
