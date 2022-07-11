
import 'package:floor/floor.dart';

@Entity(tableName: StreamHistoryEntity.TABLE_NAME)
class StreamHistoryEntity {
  @primaryKey
  int streamId;
  int accessDate;
  int repeatCount;

  StreamHistoryEntity(this.streamId, this.accessDate, this.repeatCount);
  static const String TABLE_NAME = "History";
}
