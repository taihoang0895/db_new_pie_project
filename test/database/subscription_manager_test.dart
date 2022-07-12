// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:db_new_pie_project/database/app_database.dart';
import 'package:db_new_pie_project/database/managers/subscription_manager.dart';
import 'package:db_new_pie_project/database/entities/subscription/subscription_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:db_new_pie_project/main.dart';

SubscriptionEntity fakeSubscriptionEntity(int num) {
  return SubscriptionEntity(
      num.toString(), "url_$num", "name_$num", "avatarUrl_$num", 1, "description_$num");
}

void main() {
  Future<AppDatabase> init() async {
    sqfliteFfiInit();
    AppDatabase database =
        await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
    database.subscriptionDao.clear();
    return database;
  }


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

      await subscriptionManager.deleteSubscriptionById(latest[0].id);
      await Future.delayed(Duration(milliseconds: 500));
      expect(latest.length, 1);
  });

  test('insert channel', () async {
    // fake data
    AppDatabase database = await init();
    SubscriptionManager subscriptionManager = SubscriptionManager(database);

    SubscriptionEntity subscriptionEntity1 = fakeSubscriptionEntity(1);
    SubscriptionEntity subscriptionEntity2 = fakeSubscriptionEntity(2);
    await subscriptionManager
        .insertSubscription(subscriptionEntity1);

    List<SubscriptionEntity> latest = List.empty();
    subscriptionManager.findAllSubscriptionsAsStream().listen((event) {
      latest = event;
    });
    await Future.delayed(Duration(milliseconds: 500));
    expect(latest.length, 1);
    expect(latest[0].id, subscriptionEntity1.id);

    await subscriptionManager
        .insertSubscription(subscriptionEntity2);
    await Future.delayed(Duration(milliseconds: 500));
    expect(latest.length, 2);
    expect(latest[0].id, subscriptionEntity1.id);
    expect(latest[1].id, subscriptionEntity2.id);
  });

}
