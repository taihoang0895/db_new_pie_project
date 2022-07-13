import 'package:floor/floor.dart';

const playListTableName = "Playlist";

@Entity(tableName: "Playlist")
class PlaylistEntity {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String name;

  PlaylistEntity(this.id, this.name);

  PlaylistEntity.clone(PlaylistEntity obj) : this(obj.id, obj.name);

  @override
  String toString() {
    return "id $id - name : $name";
  }

  static const String tableName = "Playlist";
}
