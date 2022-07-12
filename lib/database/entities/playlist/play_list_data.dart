import 'package:db_new_pie_project/database/entities/entities.dart';
import 'package:floor/floor.dart';

import '../stream/stream_entity.dart';
import 'play_list_entity.dart';

class PlayListData {
  PlaylistEntity playlistEntity;
  StreamEntity streamEntity;
  StreamStateEntity streamStateEntity;

  PlayListData(this.playlistEntity, this.streamEntity, this.streamStateEntity);
}