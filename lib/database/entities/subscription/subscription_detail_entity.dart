import 'package:floor/floor.dart';

@Entity(tableName: SubscriptionDetailEntity.tableName, primaryKeys: ['groupId', 'subscriptionId'])
class SubscriptionDetailEntity {
  int groupId;
  int subscriptionId;

  SubscriptionDetailEntity(this.groupId, this.subscriptionId);

  static const String tableName = "SubscriptionDetail";
}
