import 'package:db_new_pie_project/database/entities/subscription/SubscriptionGroupEntity.dart';
import 'package:floor/floor.dart';

import '../../entities/subscription/SubscriptionEntity.dart';

@dao
abstract class SubscriptionGroupDao{
  @insert
  Future<void> insertEntity(SubscriptionGroupEntity entity);

  @update
  Future<void> updateEntity(SubscriptionGroupEntity entity);

  @delete
  Future<void> deleteEntity(SubscriptionGroupEntity entity);

  @Query("DELETE FROM ${SubscriptionGroupEntity.TABLE_NAME} WHERE id=:id")
  Future<void> deleteById(String id);

  @Query("SELECT * FROM ${SubscriptionGroupEntity.TABLE_NAME} LIMIT :limit OFFSET :offset")
  Future<List<SubscriptionGroupEntity>> findAll({int limit=30, int offset=0});

  @Query("SELECT * FROM ${SubscriptionGroupEntity.TABLE_NAME} LIMIT :limit OFFSET :offset")
  Stream<List<SubscriptionGroupEntity>> findAllAsStream({int limit=30, int offset=0});

  @Query("DELETE FROM ${SubscriptionGroupEntity.TABLE_NAME}")
  Future<void> clear();
}