// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:db_new_pie_project/database/app_database.dart';
import 'package:db_new_pie_project/database/entities/history/SearchHistoryEntity.dart';
import 'package:db_new_pie_project/database/history/SearchHistoryManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:db_new_pie_project/main.dart';

void main() {
  Future<SearchHistoryManager> init() async {
    sqfliteFfiInit();
    AppDatabase database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    SearchHistoryManager searchHistoryManager =
        new SearchHistoryManager(database);
    searchHistoryManager.clear();
    return searchHistoryManager;
  }

  test('Insert a search history', () async {
    SearchHistoryManager searchHistoryManager = await init();

    await searchHistoryManager.insert("abc");
    List<SearchHistoryEntity> records = await searchHistoryManager.findAll();

    expect(records.length, 1);
    expect(records[0].search, "abc");
  });

  test('Delete a search history', () async {
    SearchHistoryManager searchHistoryManager = await init();

    searchHistoryManager.insert("abc");
    List<SearchHistoryEntity> records = await searchHistoryManager.findAll();
    searchHistoryManager.delete(records[0].id!);
    records = await searchHistoryManager.findAll();
    expect(records.length, 0);
  });

  test('Find similar text', () async {
    SearchHistoryManager searchHistoryManager = await init();
    searchHistoryManager.insert("abc");
    searchHistoryManager.insert("abc");

    List<SearchHistoryEntity> records = await searchHistoryManager.findSimilarText("abc");
    expect(records.length, 1);
  });
}
