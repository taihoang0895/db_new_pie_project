import 'package:floor/floor.dart';

import '../../entities/subscription/SubscriptionEntity.dart';

@dao
abstract class SubscriptionDao{
  @insert
  Future<void> insertEntity(SubscriptionEntity entity);

  @update
  Future<void> updateEntity(SubscriptionEntity entity);

  @delete
  Future<void> deleteEntity(SubscriptionEntity entity);

  @Query("DELETE FROM ${SubscriptionEntity.TABLE_NAME} WHERE id=:id")
  Future<void> deleteById(String id);

  @Query("SELECT * FROM ${SubscriptionEntity.TABLE_NAME} LIMIT :limit OFFSET :offset")
  Future<List<SubscriptionEntity>> findAll({int limit=30, int offset=0});

  @Query("SELECT * FROM ${SubscriptionEntity.TABLE_NAME} LIMIT :limit OFFSET :offset")
  Stream<List<SubscriptionEntity>> findAllAsStream({int limit=30, int offset=0});

  @Query("DELETE FROM ${SubscriptionEntity.TABLE_NAME}")
  Future<void> clear();
}