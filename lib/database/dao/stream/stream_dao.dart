import 'package:db_new_pie_project/database/entities/stream/stream_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class StreamDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertStream(StreamEntity entity);

  @insert
  Future<void> insertStreams(List<StreamEntity> entities);

  @Query('DELETE FROM ${StreamEntity.tableName} WHERE uid = :id')
  Future<void> deleteStreamById(String id);

  @delete
  Future<void> deleteStream(StreamEntity entity);

  @Query('SELECT * FROM ${StreamEntity.tableName}')
  Stream<List<StreamEntity>> findAllAsStream();

  @Query('SELECT * FROM ${StreamEntity.tableName} WHERE uid = :id')
  Stream<StreamEntity?> findByIdAsStream(String id);

  @Query('SELECT * FROM ${StreamEntity.tableName} WHERE uid = :id')
  Future<StreamEntity?> findById(int id);

  @Query('SELECT * FROM ${StreamEntity.tableName}')
  Future<List<StreamEntity>> findAll();

  @update
  Future<void> updateStream(StreamEntity entity);

  @Query('DELETE FROM ${StreamEntity.tableName}')
  Future<void> clear();
}
