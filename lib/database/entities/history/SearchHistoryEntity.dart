import 'package:floor/floor.dart';

@Entity(tableName: SearchHistoryEntity.TABLE_NAME)
class SearchHistoryEntity{
  @PrimaryKey(autoGenerate: true)
  int? id;

  String search;
  int creationDate;
  SearchHistoryEntity(this.id, this.search, this.creationDate);

  static const String TABLE_NAME = "SearchHistory";
}