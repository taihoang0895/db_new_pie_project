import 'package:db_new_pie_project/database/entities/stream/stream_entity.dart';
import 'package:db_new_pie_project/database/entities/history/stream_history_entity.dart';

class StreamHistory{
  int progressTime;
  StreamHistoryEntity streamHistory;
  StreamEntity streamEntity;

  StreamHistory(this.progressTime, this.streamHistory, this.streamEntity);
}