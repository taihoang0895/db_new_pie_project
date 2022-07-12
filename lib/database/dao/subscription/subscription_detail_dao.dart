import 'package:db_new_pie_project/database/entities/subscription/subscription_detail_entity.dart';
import 'package:floor/floor.dart';

import '../../entities/subscription/subscription_entity.dart';

@dao
abstract class SubscriptionDetailDao {
  @insert
  Future<void> insertEntity(
    SubscriptionDetailEntity entity,
  );

  @insert
  Future<void> insertEntities(
    List<SubscriptionDetailEntity> entities,
  );

  @update
  Future<void> updateEntity(
    SubscriptionDetailEntity entity,
  );

  @delete
  Future<void> deleteEntity(
    SubscriptionDetailEntity entity,
  );

  @Query(
      "DELETE FROM ${SubscriptionDetailEntity.tableName} WHERE groupId = :groupId AND subscriptionId = :subscriptionId")
  Future<void> deleteById(
    int groupId,
    int subscriptionId,
  );

  @Query(
      "DELETE FROM ${SubscriptionDetailEntity.tableName} WHERE groupId = :groupId")
  Future<void> deleteByGroupId(
    int groupId,
  );

  @Query(
      "SELECT * FROM ${SubscriptionDetailEntity.tableName} WHERE groupId = :groupId")
  Future<List<SubscriptionDetailEntity>> findByGroupId(
    int groupId,
  );

  @Query("SELECT * FROM ${SubscriptionDetailEntity.tableName}")
  Future<List<SubscriptionDetailEntity>> findAll();

  @Query("SELECT * FROM ${SubscriptionDetailEntity.tableName}")
  Stream<List<SubscriptionDetailEntity>> findAllAsStream();

  @Query("DELETE FROM ${SubscriptionDetailEntity.tableName}")
  Future<void> clear();
}
