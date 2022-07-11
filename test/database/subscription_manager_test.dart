// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:db_new_pie_project/database/app_database.dart';
import 'package:db_new_pie_project/database/dao/subscription/SubscriptionManager.dart';
import 'package:db_new_pie_project/database/entities/history/SearchHistoryEntity.dart';
import 'package:db_new_pie_project/database/dao/history/SearchHistoryManager.dart';
import 'package:db_new_pie_project/database/entities/subscription/SubscriptionDetailEntity.dart';
import 'package:db_new_pie_project/database/entities/subscription/SubscriptionEntity.dart';
import 'package:db_new_pie_project/database/entities/subscription/SubscriptionGroupEntity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:db_new_pie_project/main.dart';

SubscriptionEntity fakeSubscriptionEntity(int num) {
  return SubscriptionEntity(
      null, "url_$num", "name_$num", "avatarUrl_$num", 1, "description_$num");
}

void main() {
  Future<AppDatabase> init() async {
    sqfliteFfiInit();
    AppDatabase database =
        await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
    database.subscriptionDao.clear();
    database.subscriptionDetailDao.clear();
    database.subscriptionGroupDao.clear();
    return database;
  }

  test('save  channel group', () async {
    AppDatabase database = await init();
    SubscriptionManager subscriptionManager = SubscriptionManager(database);
    List<SubscriptionGroupEntity> latest = List.empty();
    subscriptionManager.findAllSubscriptionGroupAsStream().listen((event) {
      latest = event;
    });

    SubscriptionEntity subscriptionEntity1 = fakeSubscriptionEntity(1);
    SubscriptionEntity subscriptionEntity2 = fakeSubscriptionEntity(2);
    await subscriptionManager
        .insertSubscriptions([subscriptionEntity1, subscriptionEntity2]);
    List<SubscriptionEntity> subscriptionEntities =
    await subscriptionManager.findAllSubscriptions();

    await subscriptionManager.saveChannelGroup(SubscriptionGroupEntity(null, "abc", 1), subscriptionEntities);

    await Future.delayed(Duration(milliseconds: 500));
    expect(latest.length, 1);
    expect(latest[0].name, "abc");
    expect(latest[0].iconId, 1);

    List<SubscriptionEntity> subscriptions = await subscriptionManager.findSubscriptionsOfGroup(latest[0].id!);
    expect(subscriptions.length, 2);
    expect(subscriptions[0].id, subscriptionEntities[0].id);
    expect(subscriptions[1].id, subscriptionEntities[1].id);

    await subscriptionManager.saveChannelGroup(SubscriptionGroupEntity(latest[0].id!, "abc2", 2), subscriptionEntities);
    await Future.delayed(Duration(milliseconds: 500));
    expect(latest.length, 1);
    expect(latest[0].name, "abc2");
    expect(latest[0].iconId, 2);
    subscriptions = await subscriptionManager.findSubscriptionsOfGroup(latest[0].id!);
    expect(subscriptions.length, 2);
    expect(subscriptions[0].id, subscriptionEntities[0].id);
    expect(subscriptions[1].id, subscriptionEntities[1].id);

  });

  test('delete channel group', () async {
      // fake data
      AppDatabase database = await init();
      SubscriptionManager subscriptionManager = SubscriptionManager(database);
      List<SubscriptionGroupEntity> latest = List.empty();
      subscriptionManager.findAllSubscriptionGroupAsStream().listen((event) {
        latest = event;
      });

      SubscriptionEntity subscriptionEntity1 = fakeSubscriptionEntity(1);
      SubscriptionEntity subscriptionEntity2 = fakeSubscriptionEntity(2);
      await subscriptionManager
          .insertSubscriptions([subscriptionEntity1, subscriptionEntity2]);
      List<SubscriptionEntity> subscriptionEntities =
      await subscriptionManager.findAllSubscriptions();

      await subscriptionManager.saveChannelGroup(SubscriptionGroupEntity(null, "abc", 1), subscriptionEntities);

      // test
      await Future.delayed(Duration(milliseconds: 500));
      expect(latest.length, 1);
      final groupId = latest[0].id!;
      await subscriptionManager.deleteChannelGroup(groupId);

      await Future.delayed(Duration(milliseconds: 500));
      expect(latest.length, 0);
      List<SubscriptionEntity>  subscriptions = await subscriptionManager.findSubscriptionsOfGroup(groupId);
      expect(subscriptions.length, 0);
  });

  test('delete channel', () async {
      // fake data
      AppDatabase database = await init();
      SubscriptionManager subscriptionManager = SubscriptionManager(database);

      SubscriptionEntity subscriptionEntity1 = fakeSubscriptionEntity(1);
      SubscriptionEntity subscriptionEntity2 = fakeSubscriptionEntity(2);
      await subscriptionManager
          .insertSubscriptions([subscriptionEntity1, subscriptionEntity2]);

      List<SubscriptionEntity> latest = List.empty();
      subscriptionManager.findAllSubscriptionsAsStream().listen((event) {
        latest = event;
      });
      await Future.delayed(Duration(milliseconds: 500));
      expect(latest.length, 2);

      await subscriptionManager.deleteSubscriptionById(latest[0].id!);
      await Future.delayed(Duration(milliseconds: 500));
      expect(latest.length, 1);
  });

  test('save find subscriptions of group as stream', () async {
    AppDatabase database = await init();
    SubscriptionManager subscriptionManager = SubscriptionManager(database);
    List<SubscriptionGroupEntity> latest = List.empty();
    subscriptionManager.findAllSubscriptionGroupAsStream().listen((event) {
      latest = event;
    });

    SubscriptionEntity subscriptionEntity1 = fakeSubscriptionEntity(1);
    SubscriptionEntity subscriptionEntity2 = fakeSubscriptionEntity(2);
    await subscriptionManager
        .insertSubscriptions([subscriptionEntity1, subscriptionEntity2]);
    List<SubscriptionEntity> subscriptionEntities =
    await subscriptionManager.findAllSubscriptions();

    await subscriptionManager.saveChannelGroup(SubscriptionGroupEntity(null, "abc", 1), subscriptionEntities);

    await Future.delayed(Duration(milliseconds: 500));
    expect(latest.length, 1);
    expect(latest[0].name, "abc");
    expect(latest[0].iconId, 1);
    List<SubscriptionEntity>  latestSubscription = List.empty();
    subscriptionManager.findSubscriptionsOfGroupAsStream(latest[0].id!).listen((event) {
        latestSubscription = event;
    });
    await Future.delayed(Duration(milliseconds: 500));
    expect(latestSubscription.length, 2);

    await subscriptionManager.deleteSubscriptionById(latestSubscription[0].id!);
    await Future.delayed(Duration(milliseconds: 500));
    expect(latestSubscription.length, 1);

  });

}
