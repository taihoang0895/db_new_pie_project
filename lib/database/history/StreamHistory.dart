import 'package:db_new_pie_project/database/entities/StreamEntity.dart';
import 'package:db_new_pie_project/database/entities/history/StreamHistoryEntity.dart';

class StreamHistory{
  int progressTime;
  StreamHistory streamHistory;
  StreamEntity streamEntity;

  StreamHistory(this.progressTime, this.streamHistory, this.streamEntity);
}