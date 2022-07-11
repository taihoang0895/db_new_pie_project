import 'package:floor/floor.dart';

@Entity(tableName: SubscriptionGroupEntity.TABLE_NAME)
class SubscriptionGroupEntity {
  @primaryKey
  int id;
  String name;
  int iconId;

  SubscriptionGroupEntity(this.id, this.name, this.iconId);
  static const String TABLE_NAME = "SubscriptionGroup";
}
