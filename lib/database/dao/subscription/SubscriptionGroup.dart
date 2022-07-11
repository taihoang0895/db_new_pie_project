import 'package:db_new_pie_project/database/entities/subscription/SubscriptionGroupEntity.dart';

import '../../entities/subscription/SubscriptionEntity.dart';

class SubscriptionGroup{
  SubscriptionGroupEntity subscriptionGroup;
  List<SubscriptionEntity> subscriptions;

  SubscriptionGroup(this.subscriptionGroup, this.subscriptions);
}