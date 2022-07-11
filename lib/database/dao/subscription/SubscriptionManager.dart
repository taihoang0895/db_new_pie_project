import 'package:db_new_pie_project/database/entities/subscription/SubscriptionGroupEntity.dart';

import '../../app_database.dart';
import '../../entities/subscription/SubscriptionEntity.dart';
import 'SubscriptionGroup.dart';

class SubscriptionManager {
  final AppDatabase _appDatabase;

  SubscriptionManager(this._appDatabase);

  Stream<List<SubscriptionGroup>> findAllSubscriptionGroupAsStream(){
    throw Exception("");
  }

  Future<List<SubscriptionGroup>> findAllSubscriptionGroup(){
    throw Exception("");
  }

  Future<void> createChannelGroup(String name, List<SubscriptionEntity> subscriptions, {int icon = 0}){
    throw Exception("");
  }

  Future<void> deleteChannelGroup(int channelGroupId){
    throw Exception("");
  }

  Future<void> updateChannelGroup(SubscriptionGroupEntity entity, List<SubscriptionEntity> subscriptions){
    throw Exception("");
  }

  Stream<List<SubscriptionEntity>> findSubscriptionsOfGroupAsStream(int subscriptionGroupId){
    throw Exception("");
  }

  Future<List<SubscriptionEntity>> findSubscriptionsOfGroup(int subscriptionGroupId){
    throw Exception("");
  }

  Stream<List<SubscriptionEntity>> findAllSubscriptionsAsStream(){
    throw Exception("");
  }

  Future<List<SubscriptionEntity>> findAllSubscriptions(){
    throw Exception("");
  }

  Future<void> insertSubscription(SubscriptionEntity entity){
    throw Exception("");
  }
  Future<void> insertSubscriptions(List<SubscriptionEntity> entities){
    throw Exception("");
  }

  Future<void> deleteSubscription(SubscriptionEntity entity){
    throw Exception("");
  }

  Future<void> deleteSubscriptionById(int id){
    throw Exception("");
  }



}