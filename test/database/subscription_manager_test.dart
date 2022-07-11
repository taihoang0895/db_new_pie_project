// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:db_new_pie_project/database/app_database.dart';
import 'package:db_new_pie_project/database/dao/subscription/SubscriptionGroup.dart';
import 'package:db_new_pie_project/database/dao/subscription/SubscriptionManager.dart';
import 'package:db_new_pie_project/database/entities/history/SearchHistoryEntity.dart';
import 'package:db_new_pie_project/database/dao/history/SearchHistoryManager.dart';
import 'package:db_new_pie_project/database/entities/subscription/SubscriptionDetailEntity.dart';
import 'package:db_new_pie_project/database/entities/subscription/SubscriptionEntity.dart';
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

  test('create new channel group', () async {
    AppDatabase database = await init();
    SubscriptionManager subscriptionManager = SubscriptionManager(database);
    List<SubscriptionGroup> latest = List.empty();
    subscriptionManager.findAllSubscriptionGroupAsStream().listen((event) {
      latest = event;
    });

    await subscriptionManager.createChannelGroup("abc", List.empty(), icon: 1);

    List<SubscriptionGroup> subscriptionGroups =
        await subscriptionManager.findAllSubscriptionGroup();

    expect(subscriptionGroups.length, 1);
    expect(subscriptionGroups[0].subscriptionGroup.name, "abc");
    expect(subscriptionGroups[0].subscriptionGroup.iconId, 1);
    expect(subscriptionGroups[0].subscriptions.length, 0);
    await Future.delayed(Duration(milliseconds: 500));
    expect(latest.length, 1);
    expect(latest[0].subscriptionGroup.name, "abc");
    expect(latest[0].subscriptionGroup.iconId, 1);
    expect(latest[0].subscriptions.length, 0);

    SubscriptionEntity subscriptionEntity1 = fakeSubscriptionEntity(1);
    SubscriptionEntity subscriptionEntity2 = fakeSubscriptionEntity(2);
    subscriptionManager
        .insertSubscriptions([subscriptionEntity1, subscriptionEntity2]);
    List<SubscriptionEntity> subscriptionEntities =
        await subscriptionManager.findAllSubscriptions();

    await subscriptionManager.createChannelGroup("abc2", subscriptionEntities,
        icon: 1);

    subscriptionGroups = await subscriptionManager.findAllSubscriptionGroup();
    expect(subscriptionGroups.length, 2);
    expect(subscriptionGroups[0].subscriptionGroup.name, "abc2");
    expect(subscriptionGroups[0].subscriptionGroup.iconId, 1);
    expect(subscriptionGroups[0].subscriptions.length, 2);
    await Future.delayed(Duration(milliseconds: 500));
    expect(latest.length, 1);
    expect(latest[0].subscriptionGroup.name, "abc2");
    expect(latest[0].subscriptionGroup.iconId, 1);
    expect(latest[0].subscriptions.length, 2);
  });

  test('delete channel group', () async {
    AppDatabase database = await init();
    SubscriptionManager subscriptionManager = SubscriptionManager(database);
    List<SubscriptionGroup> latest = List.empty();
    subscriptionManager.findAllSubscriptionGroupAsStream().listen((event) {
      latest = event;
    });

    SubscriptionEntity subscriptionEntity1 = fakeSubscriptionEntity(1);
    SubscriptionEntity subscriptionEntity2 = fakeSubscriptionEntity(2);
    subscriptionManager
        .insertSubscriptions([subscriptionEntity1, subscriptionEntity2]);
    List<SubscriptionEntity> subscriptionEntities =
    await subscriptionManager.findAllSubscriptions();

    await subscriptionManager.createChannelGroup("abc2", subscriptionEntities,
        icon: 1);

    await Future.delayed(Duration(milliseconds: 500));
    expect(latest.length, 1);
    expect(latest[0].subscriptionGroup.name, "abc2");
    expect(latest[0].subscriptionGroup.iconId, 1);
    expect(latest[0].subscriptions.length, 1);


    subscriptionManager.deleteChannelGroup(latest[0].subscriptionGroup.id);
    await Future.delayed(Duration(milliseconds: 500));
    expect(latest.length, 0);
  });

  test('delete channel group', () async {
    AppDatabase database = await init();
    SubscriptionManager subscriptionManager = SubscriptionManager(database);
    List<SubscriptionGroup> latest = List.empty();
    subscriptionManager.findAllSubscriptionGroupAsStream().listen((event) {
      latest = event;
    });

    SubscriptionEntity subscriptionEntity1 = fakeSubscriptionEntity(1);
    SubscriptionEntity subscriptionEntity2 = fakeSubscriptionEntity(2);
    subscriptionManager
        .insertSubscriptions([subscriptionEntity1, subscriptionEntity2]);
    List<SubscriptionEntity> subscriptionEntities =
        await subscriptionManager.findAllSubscriptions();

    await subscriptionManager.createChannelGroup("abc2", subscriptionEntities,
        icon: 1);

    await Future.delayed(Duration(milliseconds: 500));
    expect(latest.length, 1);
    expect(latest[0].subscriptionGroup.name, "abc2");
    expect(latest[0].subscriptionGroup.iconId, 1);
    expect(latest[0].subscriptions.length, 1);


    subscriptionManager.deleteChannelGroup(latest[0].subscriptionGroup.id);
    await Future.delayed(Duration(milliseconds: 500));
    expect(latest.length, 0);
    List<SubscriptionDetailEntity> subscriptionDetailEntities = await database.subscriptionDetailDao.findByGroupId(latest[0].subscriptionGroup.id);
    expect(subscriptionDetailEntities.length, 0);
  });
}
