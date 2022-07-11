// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:db_new_pie_project/database/app_database.dart';
import 'package:db_new_pie_project/database/dao/stream/StreamManager.dart';
import 'package:db_new_pie_project/database/entities/history/StreamHistoryEntity.dart';
import 'package:db_new_pie_project/database/entities/history/StreamStateEntity.dart';
import 'package:db_new_pie_project/database/entities/stream/StreamEntity.dart';
import 'package:db_new_pie_project/database/entities/history/SearchHistoryEntity.dart';
import 'package:db_new_pie_project/database/dao/history/HistoryManager.dart';
import 'package:db_new_pie_project/database/dao/history/SearchHistoryManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:db_new_pie_project/main.dart';

import 'stream_manager_test.dart';

void main() {

  Future<AppDatabase> init() async {
    sqfliteFfiInit();
    AppDatabase database =
    await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
    database.historyDao.clearSearchHistory();
    database.streamDao.clear();
    return database;
  }

  test('Save a Stream History', () async {
    AppDatabase database = await init();
    HistoryManager historyManager = HistoryManager(database);
    StreamManager streamManager = new StreamManager(database);
    StreamEntity streamEntity1 = fakeStreamEntity(1);
    StreamEntity streamEntity2 = fakeStreamEntity(2);
    streamManager.insertList([streamEntity1, streamEntity2]);

    await historyManager.save(streamEntity1.uid);
    List<StreamHistoryEntity> records = await historyManager.findAllHistoryEntities();
    expect(records.length, 1);
    expect(records[0].streamId, streamEntity1.uid);

    await historyManager.save(streamEntity2.uid);
    records = await historyManager.findAllHistoryEntities();
    expect(records.length, 2);
    expect(records[0].streamId, streamEntity2.uid);
    expect(records[1].streamId, streamEntity1.uid);

    await historyManager.save(streamEntity1.uid);
    records = await historyManager.findAllHistoryEntities();
    expect(records.length, 2);
    expect(records[1].streamId, streamEntity2.uid);
    expect(records[0].streamId, streamEntity1.uid);
  });

  test('Delete a Stream History', () async {
    AppDatabase database = await init();
    HistoryManager historyManager = HistoryManager(database);
    StreamManager streamManager = new StreamManager(database);
    StreamEntity streamEntity1 = fakeStreamEntity(1);
    StreamEntity streamEntity2 = fakeStreamEntity(2);
    streamManager.insertList([streamEntity1, streamEntity2]);

    List<StreamHistoryEntity> latest = List.empty();

    historyManager.findAllHistoryEntitiesAsStream().listen((records) {
      latest = records;
    });
    await historyManager.save(streamEntity1.uid);
    await Future.delayed(Duration(milliseconds: 500));
    expect(latest.length, 1);

    await historyManager.delete(latest[0].streamId);
    await Future.delayed(Duration(milliseconds: 500));
    expect(latest.length, 0);
  });

  test('Clear a Stream History', () async {
    AppDatabase database = await init();
    HistoryManager historyManager = HistoryManager(database);
    StreamManager streamManager = new StreamManager(database);
    StreamEntity streamEntity1 = fakeStreamEntity(1);
    StreamEntity streamEntity2 = fakeStreamEntity(2);
    streamManager.insertList([streamEntity1, streamEntity2]);

    List<StreamHistoryEntity> latest = List.empty();

    historyManager.findAllHistoryEntitiesAsStream().listen((records) {
      latest = records;
    });
    await historyManager.save(streamEntity1.uid);
    await historyManager.save(streamEntity2.uid);
    await Future.delayed(Duration(milliseconds: 500));
    expect(latest.length, 2);

    await historyManager.clear();
    await Future.delayed(Duration(milliseconds: 500));
    expect(latest.length, 0);
  });

  test('Update Progress Time', () async {
    AppDatabase database = await init();
    HistoryManager historyManager = HistoryManager(database);
    StreamManager streamManager = new StreamManager(database);
    StreamEntity streamEntity1 = fakeStreamEntity(1);
    StreamEntity streamEntity2 = fakeStreamEntity(2);
    streamManager.insertList([streamEntity1, streamEntity2]);

    await historyManager.updateProgressTime(streamEntity1.uid, 5000);
    StreamStateEntity? streamState = await historyManager.firstOrNullStreamState(streamEntity1.uid);
    expect(streamState != null, true);
    expect(streamState!.progressTime, 5000);

    await historyManager.updateProgressTime(streamEntity1.uid, 10000);
    streamState = await historyManager.firstOrNullStreamState(streamEntity1.uid);
    expect(streamState != null, true);
    expect(streamState!.progressTime, 10000);
    // test notify to Stream History Table
  });

  test('Increase View Count', () async {
    AppDatabase database = await init();
    HistoryManager historyManager = HistoryManager(database);
    StreamManager streamManager = new StreamManager(database);
    StreamEntity streamEntity1 = fakeStreamEntity(1);
    StreamEntity streamEntity2 = fakeStreamEntity(2);
    streamManager.insertList([streamEntity1, streamEntity2]);

    List<StreamHistoryEntity> latest = List.empty();

    historyManager.findAllHistoryEntitiesAsStream().listen((records) {
      latest = records;
    });

    await historyManager.increaseViewCount(streamEntity1.uid);
    await Future.delayed(Duration(milliseconds: 500));
    expect(latest.length, 1);
    expect(latest[0].repeatCount, 1);

    await historyManager.increaseViewCount(streamEntity2.uid);
    await Future.delayed(Duration(milliseconds: 500));
    expect(latest.length, 2);
    expect(latest[0].streamId, streamEntity2.uid);
    expect(latest[0].repeatCount, 1);
    expect(latest[1].streamId, streamEntity1.uid);
    expect(latest[1].repeatCount, 1);

    await historyManager.increaseViewCount(streamEntity1.uid);
    await Future.delayed(Duration(milliseconds: 500));
    expect(latest.length, 2);
    expect(latest[0].streamId, streamEntity1.uid);
    expect(latest[0].repeatCount, 2);
    expect(latest[1].streamId, streamEntity2.uid);
    expect(latest[1].repeatCount, 1);
  });

}
