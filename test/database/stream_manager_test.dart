// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:db_new_pie_project/database/app_database.dart';
import 'package:db_new_pie_project/database/dao/stream/stream_manager.dart';
import 'package:db_new_pie_project/database/entities/stream/stream_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

StreamEntity fakeStreamEntity(int id){
  return StreamEntity(id, "url_$id", "title_$id", StreamType.VIDEO_STREAM.name, 10000, "uploader_$id", "uploaderUrl_$id", 0, "textualUploadDate_$id", DateTime.now().millisecondsSinceEpoch);
}

void main() {
  
  Future<StreamManager> init() async {
    sqfliteFfiInit();
    AppDatabase database =
    await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
    StreamManager streamManager =
    new StreamManager(database);
    streamManager.clear();
    return streamManager;
  }

  test('Insert a Stream', () async {
    StreamManager streamManager = await init();
    StreamEntity entity1 = fakeStreamEntity(1);
    await streamManager.insert(entity1);
    List<StreamEntity> records = await streamManager.findAll();
    expect(records.length, 1);
    expect(records[0].uid, entity1.uid);
    List<StreamEntity> entities = List.unmodifiable([fakeStreamEntity(2), fakeStreamEntity(3)]);
    await streamManager.insertEntities(entities);
    records = await streamManager.findAll();
    expect(records.length, 3);


  });

  test('Delete a Stream',() async {
    StreamManager streamManager = await init();
    StreamEntity entity1 = fakeStreamEntity(1);
    await streamManager.insert(entity1);

    await streamManager.deleteById(entity1.uid);


    List<StreamEntity> records = await streamManager.findAll();
    expect(records.length, 0);
  });
  
  
  test('Listen Stream are changed', () async {
    StreamManager streamManager = await init();
    StreamEntity entity1 = fakeStreamEntity(1);
    await streamManager.insert(entity1);

    Stream<List<StreamEntity>> listStreams = streamManager.findAllAsStream();
    List<StreamEntity> latest = List.empty();
    listStreams.listen((streams) {
        latest = streams;
    });
    await Future.delayed(Duration(milliseconds: 1000));
    expect(latest.length, 1);
    await streamManager.deleteById(entity1.uid);
    await Future.delayed(Duration(milliseconds: 1000));
    expect(latest.length, 0);
  });

  test('Update an stream', () async {
    StreamManager streamManager = await init();
    StreamEntity entity1 = fakeStreamEntity(1);
    await streamManager.insert(entity1);

    Stream<StreamEntity?> item = streamManager.findFirstOrNull(entity1.uid);
    StreamEntity? latest = null;
    item.listen((stream) {
      latest = stream;
    });
    await Future.delayed(Duration(milliseconds: 1000));
    expect(latest != null, true);
    entity1.url = "abcsf";
    await streamManager.update(entity1);
    await Future.delayed(Duration(milliseconds: 1000));
    expect(latest!.url, "abcsf");
  });
}
