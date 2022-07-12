// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:db_new_pie_project/database/app_database.dart';
import 'package:db_new_pie_project/database/dao/history/history_dao.dart';
import 'package:db_new_pie_project/database/managers/history_manager.dart';
import 'package:db_new_pie_project/database/dao/playlist/play_list_dao.dart';
import 'package:db_new_pie_project/database/dao/playlist/play_list_details_dao.dart';
import 'package:db_new_pie_project/database/dao/playlist/play_list_manager.dart';
import 'package:db_new_pie_project/database/dao/stream/stream_dao.dart';
import 'package:db_new_pie_project/database/dao/stream/stream_manager.dart';
import 'package:db_new_pie_project/database/entities/entities.dart';
import 'package:db_new_pie_project/database/entities/playlist/play_list_data.dart';
import 'package:db_new_pie_project/database/entities/playlist/play_list_entity.dart';
import 'package:db_new_pie_project/database/entities/playlist/play_list_detail_entity.dart';
import 'package:db_new_pie_project/database/entities/stream/stream_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
/*

void main() {
  Future<AppDatabase> init() async {
    sqfliteFfiInit();
    AppDatabase database =
        await $FloorAppDatabase.inMemoryDatabaseBuilder().build();

    return database;
  }

  Future<void> clear(AppDatabase db) async {
    await db.playListDao.clearPLayList();
    await db.streamDao.clear();
    await db.detailsDao.clearDetails();
    await db.historyDao.clearStreamHistory();
  }

  Future<void> addStream(StreamDao dao, int count) async {
    for (int i = 0; i < count; i++) {
      await dao.insertStream(StreamEntity(
          i + 1,
          "https://test.com${(i + 1)}",
          "tile",
          "streamType",
          Random().nextInt(100000),
          "manh",
          "uploaderUrl",
          i + 1,
          "textualUploadDate",
          10990));
    }
  }

  Future<void> addPlayList(PlaylistDao playDao, int count) async {
    for (int i = 0; i < count; i++) {
      await playDao.addPlaylist(PlaylistEntity(i + 1, "hello${(i + 1)}"));
    }
  }

  test('test add PlayList', () async {
    AppDatabase db = await init();
    await clear(db);
    PlayListManager playListManager = PlayListManager(db);

    List<PlaylistEntity> latest = List.empty();

    playListManager.findAllPlayListAsStream().listen((data) {
      latest = data;
    });

    await addStream(db.streamDao, 1);
    await playListManager.createPlaylist("playList1", 1);

    await Future.delayed(Duration(milliseconds: 500));

    expect(latest.length, 1);
    expect(latest[0].id, 1);
  });

  test('test addStream to PLayList', () async {
    AppDatabase db = await init();
    await clear(db);
    PlayListManager playListManager = PlayListManager(db);

    await addStream(db.streamDao, 4);
    await playListManager.createPlaylist("playList1", 1);

    await playListManager.addStreamToPlayList(1, 2);
    await playListManager.addStreamToPlayList(1, 3);

    var playListDetail = await playListManager.findAllPlayListDetail();

    expect(playListDetail.length, 3);
  });

  test('test getStreamFromPlayList', () async {
    AppDatabase db = await init();
    await clear(db);

    PlayListManager playListManager = PlayListManager(db);

    List<PlaylistEntity> latestPlayList = List.empty();
    List<PlayListData> latestStreams = List.empty();

    playListManager.findAllPlayListAsStream().listen((data) {
      latestPlayList = data;
    });

    await addStream(db.streamDao, 4);
    await playListManager.createPlaylist("playList1", 1);

    playListManager.getListStreamFromPlayList(1).listen((data) {
      latestStreams = data;
    });

    await Future.delayed(Duration(milliseconds: 500));
    expect(latestPlayList.length, 1);
    expect(latestStreams.length, 1);
    expect(latestStreams[0].playlistDetailEntity.playlistId, latestPlayList[0].id);

    await playListManager.addStreamToPlayList(latestPlayList[0].id, 2);
    await Future.delayed(Duration(milliseconds: 500));

    //var a = await playListManager.getStreamData(latestPlayList[0].id);
    expect(latestStreams.length, 2);
    expect(latestStreams[0].streamEntity.uid, 1);
    expect(latestStreams[1].streamEntity.uid, 2);
  });

  test('test updateNamePlayList', () async {
    AppDatabase db = await init();
    PlaylistDao playDao = db.playListDao;
    await clear(db);
    PlayListManager playListManager = PlayListManager(db);

    addStream(db.streamDao, 3);

    await playListManager.createPlaylist("hello", 1);
    await playListManager.createPlaylist("playList2", 2);
    await playListManager.createPlaylist("playList3", 2);

    await playListManager.updateNamePlayList("newName", 1);

    var items = await playDao.findAll();
    expect(items[0].name, "newName");
    expect(items[1].name, "playList2");
    expect(items[2].name, "playList3");
  });

  test('test removeStreamFromPLayList', () async {
    AppDatabase db = await init();
    await clear(db);
    PlayListManager playListManager = PlayListManager(db);

    await addStream(db.streamDao, 4);
    await playListManager.createPlaylist("playList1", 1);

    await playListManager.addStreamToPlayList(1, 2);
    await playListManager.addStreamToPlayList(1, 3);

    await playListManager.removeStreamFromPLayList(1, 1);
    var list = await playListManager.getStreamData(1);

    expect(list.length, 2);
    expect(list[0].streamEntity.uid, 2);
    expect(list[1].streamEntity.uid, 3);
  });

  test('test changeProgressTime', () async {
    AppDatabase db = await init();
    await clear(db);
    PlayListManager playListManager = PlayListManager(db);

    await addStream(db.streamDao, 4);
    await playListManager.createPlaylist("playList1", 1);

    await playListManager.addStreamToPlayList(1, 2);
    await playListManager.addStreamToPlayList(1, 3);

    await db.historyDao.updateStreamStateEntity(StreamStateEntity(2, 234));
    await db.historyDao.updateStreamStateEntity(StreamStateEntity(3, 9999));
    var list = await playListManager.getStreamData(1);

    expect(list[0].streamStateEntity.progressTime, 0);
    expect(list[1].streamStateEntity.progressTime, 234);
    expect(list[2].streamStateEntity.progressTime, 9999);
  });

  test('test deletePlayList', () async {
    AppDatabase db = await init();
    await clear(db);
    PlayListManager playListManager = PlayListManager(db);

    await addStream(db.streamDao, 3);
    await playListManager.createPlaylist("playList1", 1);
    await playListManager.createPlaylist("playList2", 2);

    await playListManager.deletePlayList(1);

    var playListData = await playListManager.findAllPlayList();
    var playListDetail = await playListManager.findAllPlayListDetail();

    expect(playListData.length, 1);
    expect(playListDetail.length, 1);
    expect(playListDetail[0].streamId, 2);
  });

  test('test reOderListStream', () async {
    AppDatabase db = await init();
    await clear(db);
    PlayListManager playListManager = PlayListManager(db);

    await addStream(db.streamDao, 3);
    await playListManager.createPlaylist("playList1", 1);

    await playListManager.addStreamToPlayList(1, 2);
    await playListManager.addStreamToPlayList(1, 3);
    var data = await playListManager.getStreamData(1);
    data.reversed;

    await playListManager.reOderListStream(data);

    await Future.delayed(const Duration(milliseconds: 500));

    var list = await playListManager.getStreamData(1);

    expect(list[0].playlistDetailEntity, 3);
  });
}
*/
