import 'package:floor/floor.dart';

@Entity(tableName: StreamHistoryEntity.tableName)
class StreamHistoryEntity {
  @primaryKey
  String streamId;
  int accessDate;
  int repeatCount;

  StreamHistoryEntity(this.streamId, this.accessDate, this.repeatCount);

  static const String tableName = "History";
}
