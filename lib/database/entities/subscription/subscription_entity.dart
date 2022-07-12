import 'package:floor/floor.dart';

@Entity(tableName: SubscriptionEntity.tableName)
class SubscriptionEntity {
  @primaryKey
  String id;
  String url;
  String name;
  String avatarUrl;
  int subscriberCount;
  String description;

  SubscriptionEntity(this.id, this.url, this.name, this.avatarUrl,
      this.subscriberCount, this.description);

  static const String tableName = "Subscription";
}
