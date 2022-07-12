// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:db_new_pie_project/database/app_database.dart';
import 'package:db_new_pie_project/database/dao/history/history_dao.dart';
import 'package:db_new_pie_project/database/dao/history/histoty_manager.dart';
import 'package:db_new_pie_project/database/dao/playlist/play_list_dao.dart';
import 'package:db_new_pie_project/database/dao/playlist/play_list_details_dao.dart';
import 'package:db_new_pie_project/database/dao/playlist/play_list_manager.dart';
import 'package:db_new_pie_project/database/dao/stream/stream_dao.dart';
import 'package:db_new_pie_project/database/dao/stream/stream_manager.dart';
import 'package:db_new_pie_project/database/entities/entities.dart';
import 'package:db_new_pie_project/database/entities/playlist/play_list_entity.dart';
import 'package:db_new_pie_project/database/entities/playlist/play_list_detail_entity.dart';
import 'package:db_new_pie_project/database/entities/stream/stream_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

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

  test('test add Stream', () async {
    AppDatabase db = await init();
    StreamManager mgrStream = StreamManager(db);

    await clear(db);

    await addStream(db.streamDao, 1);

    var list = await mgrStream.findAll();
    expect(list.length, 1);
  });

  test('test add PlayList', () async {
    AppDatabase db = await init();
    PlayListManager mgr = PlayListManager(db);

    await clear(db);

    await addPlayList(db.playListDao, 1);

    var list = await mgr.findAllPlayList();
    expect(list.length, 1);
  });

  test('test add Detail', () async {
    AppDatabase db = await init();
    PlayListManager mgr = PlayListManager(db);
    await clear(db);

    await db.detailsDao.addPlaylistDetail(
        PlaylistDetailEntity(playlistId: 1, streamId: 1, joinIndex: 1));

    var list = await mgr.findAllPlayListDetail();
    expect(list.length, 1);
  });

  test('test add PlaylistDetails', () async {
    AppDatabase db = await init();
    PlayListManager mgr = PlayListManager(db);

    await clear(db);

    await addStream(db.streamDao, 1);
    await addPlayList(db.playListDao, 1);
    await db.historyDao.insertStreamStateEntity(StreamStateEntity(1, 1000));

    await db.detailsDao.addPlaylistDetail(
        PlaylistDetailEntity(playlistId: 1, streamId: 1, joinIndex: 1));

    var list = await mgr.getStreamData(1);
    expect(list[0].streamEntity.url, "https://test.com1");
  });

  test('test deletePlayListDetail', () async {
    AppDatabase db = await init();
    PlaylistDao playDao = db.playListDao;
    PlayListDetailsDao detailsDao = db.detailsDao;

    await clear(db);

    await addStream(db.streamDao, 1);
    await addPlayList(playDao, 1);
    await db.historyDao.insertStreamStateEntity(StreamStateEntity(1, 1000));

    var detail = PlaylistDetailEntity(playlistId: 1, streamId: 1, joinIndex: 1);

    await detailsDao.addPlaylistDetail(detail);

    var index = await detailsDao.deletePlayListDetail(detail);
    expect(index, 1);
  });

  test('test getStreamFromPlayList', () async {
    AppDatabase db = await init();
    PlaylistDao playDao = db.playListDao;
    PlayListDetailsDao detailsDao = db.detailsDao;
    PlayListManager mgr = PlayListManager(db);

    await clear(db);

    await addStream(db.streamDao, 3);
    await addPlayList(playDao, 4);

    await db.historyDao.insertStreamStateEntity(StreamStateEntity(1, 4222));
    await db.historyDao.insertStreamStateEntity(StreamStateEntity(2, 2343));
    await db.historyDao.insertStreamStateEntity(StreamStateEntity(3, 4234234));

    await detailsDao.addPlaylistDetail(
        PlaylistDetailEntity(playlistId: 1, streamId: 1, joinIndex: 1));
    await detailsDao.addPlaylistDetail(
        PlaylistDetailEntity(playlistId: 1, streamId: 2, joinIndex: 2));

    await detailsDao.addPlaylistDetail(
        PlaylistDetailEntity(playlistId: 1, streamId: 3, joinIndex: 3));

    await detailsDao.addPlaylistDetail(
        PlaylistDetailEntity(playlistId: 1, streamId: 4, joinIndex: 4));

    var list = await mgr.getStreamData(1);
    expect(list.length, 3);
  });

  test('test updateNamePlayList', () async {
    AppDatabase db = await init();
    PlaylistDao playDao = db.playListDao;
    PlayListDetailsDao detailsDao = db.detailsDao;

    await clear(db);

    await addPlayList(playDao, 1);

    var itemUpdate = PlaylistEntity.clone(PlaylistEntity(1, "newName"));
    await playDao.renamePlayList(itemUpdate);

    var newItem = await playDao.findPlayListByID(1);
    expect(newItem?.name, "newName");
  });

  test('test reOderListStream', () async {
    AppDatabase db = await init();
    PlaylistDao playDao = db.playListDao;
    PlayListDetailsDao detailsDao = db.detailsDao;
    PlayListManager mgr = PlayListManager(db);

    await clear(db);

    await addStream(db.streamDao, 3);
    await addPlayList(playDao, 1);

    var item1 = PlaylistDetailEntity(playlistId: 1, streamId: 1, joinIndex: 1);
    var item2 = PlaylistDetailEntity(playlistId: 1, streamId: 2, joinIndex: 2);
    var item3 = PlaylistDetailEntity(playlistId: 1, streamId: 3, joinIndex: 3);

    await db.historyDao.insertStreamStateEntity(StreamStateEntity(1, 1000));
    await db.historyDao.insertStreamStateEntity(StreamStateEntity(2, 1000));
    await db.historyDao.insertStreamStateEntity(StreamStateEntity(3, 1000));

    await detailsDao.addPlaylistDetail(item1);
    await detailsDao.addPlaylistDetail(item2);
    await detailsDao.addPlaylistDetail(item3);

    await detailsDao.updatePlayListDetail(PlaylistDetailEntity.clone(
        PlaylistDetailEntity(
            playlistId: item2.playlistId,
            streamId: item2.streamId,
            joinIndex: 3)));
    await detailsDao.updatePlayListDetail(PlaylistDetailEntity.clone(
        PlaylistDetailEntity(
            playlistId: item3.playlistId,
            streamId: item3.streamId,
            joinIndex: 2)));
    var list = await mgr.getStreamData(1);

    expect(list[1].streamEntity.uid, 3);
  });

  test('test removeStreamFromPLayList', () async {
    AppDatabase db = await init();
    PlaylistDao playDao = db.playListDao;
    PlayListDetailsDao detailsDao = db.detailsDao;
    PlayListManager mgr = PlayListManager(db);

    await clear(db);

    await addPlayList(playDao, 2);
    await addStream(db.streamDao, 4);

    var item1 = PlaylistDetailEntity(playlistId: 1, streamId: 1, joinIndex: 1);
    var item2 = PlaylistDetailEntity(playlistId: 1, streamId: 2, joinIndex: 2);
    var item3 = PlaylistDetailEntity(playlistId: 1, streamId: 3, joinIndex: 3);

    await db.historyDao.insertStreamStateEntity(StreamStateEntity(1, 1000));
    await db.historyDao.insertStreamStateEntity(StreamStateEntity(2, 1000));
    await db.historyDao.insertStreamStateEntity(StreamStateEntity(3, 1000));

    await detailsDao.addPlaylistDetail(item1);
    await detailsDao.addPlaylistDetail(item2);
    await detailsDao.addPlaylistDetail(item3);

    await detailsDao.deleteStreamFromPlayList(1, 2);
    var list = await mgr.getStreamData(1);
    expect(list.length, 2);
  });

  test('test changeProgressTime', () async {
    AppDatabase db = await init();
    PlaylistDao playDao = db.playListDao;
    PlayListDetailsDao detailsDao = db.detailsDao;
    SearchHistoryDao historyDao = db.historyDao;
    PlayListManager mgr = PlayListManager(db);

    await clear(db);

    await addPlayList(playDao, 1);
    await addStream(db.streamDao, 1);
    await historyDao.insertStreamStateEntity(StreamStateEntity(1, 10000));

    var item1 = PlaylistDetailEntity(playlistId: 1, streamId: 1, joinIndex: 1);
    await detailsDao.addPlaylistDetail(item1);


    var list = await mgr.getStreamData(1);
    expect(list[0].streamStateEntity.progressTime, 10000);
  });
}
