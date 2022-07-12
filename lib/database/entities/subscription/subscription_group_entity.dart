import 'package:floor/floor.dart';

@Entity(tableName: SubscriptionGroupEntity.tableName)
class SubscriptionGroupEntity {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String name;
  int iconId;

  SubscriptionGroupEntity(this.id, this.name, this.iconId);
  static const String tableName = "SubscriptionGroup";
}
