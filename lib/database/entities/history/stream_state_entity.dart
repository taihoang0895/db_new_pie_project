import 'package:floor/floor.dart';

@Entity(tableName: StreamStateEntity.tableName)
class StreamStateEntity {
  @primaryKey
  String streamId;
  int progressTime;

  StreamStateEntity(this.streamId, this.progressTime);
  static const String tableName = "StreamState";

}
