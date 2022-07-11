import 'package:floor/floor.dart';

@Entity(tableName: SubscriptionDetailEntity.TABLE_NAME, primaryKeys: ['groupId', 'subscriptionId'])
class SubscriptionDetailEntity {
  int groupId;
  int subscriptionId;

  SubscriptionDetailEntity(this.groupId, this.subscriptionId);

  static const String TABLE_NAME = "SubscriptionDetail";
}
