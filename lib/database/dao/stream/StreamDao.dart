
import 'package:db_new_pie_project/database/entities/stream/StreamEntity.dart';
import 'package:floor/floor.dart';

@dao
abstract class StreamDao{
  @insert
  Future<void> insertStream(StreamEntity entity);

  @insert
  Future<void> insertStreams(List<StreamEntity> entities);

  @Query('DELETE FROM ${StreamEntity.TABLE_NAME} WHERE uid = :id')
  Future<void> deleteStreamById(int id);

  @delete
  Future<void> deleteStream(StreamEntity entity);

  @Query('SELECT * FROM ${StreamEntity.TABLE_NAME}')
  Stream<List<StreamEntity>> watchAll();

  @Query('SELECT * FROM ${StreamEntity.TABLE_NAME} WHERE uid = :id')
  Stream<StreamEntity?> watchStream(int id);

  @Query('SELECT * FROM ${StreamEntity.TABLE_NAME}')
  Future<List<StreamEntity>> findAll();

  @update
  Future<void> updateStream(StreamEntity entity);

  @Query('DELETE FROM ${StreamEntity.TABLE_NAME}')
  Future<void> clear();
}