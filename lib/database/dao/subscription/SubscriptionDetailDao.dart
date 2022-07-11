import 'package:db_new_pie_project/database/entities/subscription/SubscriptionDetailEntity.dart';
import 'package:floor/floor.dart';

import '../../entities/subscription/SubscriptionEntity.dart';

@dao
abstract class SubscriptionDetailDao{
  @insert
  Future<void> insertEntity(SubscriptionDetailEntity entity);

  @update
  Future<void> updateEntity(SubscriptionDetailEntity entity);

  @delete
  Future<void> deleteEntity(SubscriptionDetailEntity entity);

  @Query("DELETE FROM ${SubscriptionDetailEntity.TABLE_NAME} WHERE groupId = :groupId AND subscriptionId = :subscriptionId")
  Future<void> deleteById(int groupId, int subscriptionId);

  @Query("SELECT * FROM ${SubscriptionDetailEntity.TABLE_NAME} WHERE groupId = :groupId")
  Future<List<SubscriptionDetailEntity>> findByGroupId(int groupId);

  @Query("SELECT * FROM ${SubscriptionDetailEntity.TABLE_NAME} LIMIT :limit OFFSET :offset")
  Future<List<SubscriptionDetailEntity>> findAll({int limit=30, int offset=0});

  @Query("SELECT * FROM ${SubscriptionDetailEntity.TABLE_NAME} LIMIT :limit OFFSET :offset")
  Stream<List<SubscriptionDetailEntity>> findAllAsStream({int limit=30, int offset=0});

  @Query("DELETE FROM ${SubscriptionDetailEntity.TABLE_NAME}")
  Future<void> clear();
}