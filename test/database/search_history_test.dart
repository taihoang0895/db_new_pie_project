// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:db_new_pie_project/database/app_database.dart';
import 'package:db_new_pie_project/database/entities/history/search_history_entity.dart';
import 'package:db_new_pie_project/database/managers/search_history_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:db_new_pie_project/main.dart';

void main() {
  Future<SearchHistoryManager> init() async {
    sqfliteFfiInit();
    AppDatabase database =
        await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
    SearchHistoryManager searchHistoryManager =
        new SearchHistoryManager(database);
    searchHistoryManager.clear();
    return searchHistoryManager;
  }

  test('Insert a search history', () async {
    SearchHistoryManager searchHistoryManager = await init();

    await searchHistoryManager.onSearched("abc");
    List<SearchHistoryEntity> records = await searchHistoryManager.findAll();

    expect(records.length, 1);
    expect(records[0].search, "abc");

    await searchHistoryManager.onSearched("abc1");
    records = await searchHistoryManager.findAll();
    expect(records.length, 2);
    expect(records[0].search, "abc1");
    expect(records[1].search, "abc");

    await searchHistoryManager.onSearched("abc");
    records = await searchHistoryManager.findAll();
    expect(records.length, 2);
    expect(records[0].search, "abc");
    expect(records[1].search, "abc1");
  });

  test('Delete a search history', () async {
    SearchHistoryManager searchHistoryManager = await init();

    await searchHistoryManager.onSearched("abc");
    List<SearchHistoryEntity> records = await searchHistoryManager.findAll();
    searchHistoryManager.delete(records[0].search);
    records = await searchHistoryManager.findAll();
    expect(records.length, 0);
  });

  test('Find Similar Text', () async {
    SearchHistoryManager searchHistoryManager = await init();

    await searchHistoryManager.onSearched("abc");

    List<SearchHistoryEntity> latest = await searchHistoryManager.findSimilarText("a");
    expect(latest.length, 1);
    expect(latest[0].search, "abc");

    await searchHistoryManager.onSearched("acb");
    latest = await searchHistoryManager.findSimilarText("a");
    expect(latest.length, 2);
    expect(latest[0].search, "acb");
    expect(latest[1].search, "abc");

    await searchHistoryManager.delete(latest[0].search);
    latest = await searchHistoryManager.findSimilarText("a");
    expect(latest.length, 1);
    expect(latest[0].search, "abc");
  });

  test('2 Find Similar Text With Empty Text', () async {
    SearchHistoryManager searchHistoryManager = await init();
    await searchHistoryManager.onSearched("abc1");
    await searchHistoryManager.onSearched("abc2");
    await searchHistoryManager.onSearched("abc3");

    List<SearchHistoryEntity> latest = await searchHistoryManager.findSimilarText("");

    expect(latest.length, 3);
    await searchHistoryManager.delete(latest[1].search);

    latest = await searchHistoryManager.findSimilarText("");
    expect(latest.length, 2);
    expect(latest[0].search, "abc3");
    expect(latest[1].search, "abc1");
  });
}
