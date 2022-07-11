import 'package:db_new_pie_project/database/entities/stream/StreamEntity.dart';
import 'package:db_new_pie_project/database/entities/history/StreamHistoryEntity.dart';

class StreamHistory{
  int progressTime;
  StreamHistoryEntity streamHistory;
  StreamEntity streamEntity;

  StreamHistory(this.progressTime, this.streamHistory, this.streamEntity);
}