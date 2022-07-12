import 'package:db_new_pie_project/database/entities/entities.dart';
import 'package:db_new_pie_project/database/entities/playlist/play_list_detail_entity.dart';

import '../stream/stream_entity.dart';

class StreamData {
  StreamEntity streamEntity;
  int processTime ;
  int joinIndex;

  StreamData(this.streamEntity, this.processTime, this.joinIndex);
}