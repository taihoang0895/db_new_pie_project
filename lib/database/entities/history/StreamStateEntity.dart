import 'package:floor/floor.dart';

@Entity(tableName: StreamStateEntity.TABLE_NAME)
class StreamStateEntity {
  @primaryKey
  int streamId;
  int progressTime;

  StreamStateEntity(this.streamId, this.progressTime);
  static const String TABLE_NAME = "StreamState";

}
