import 'package:db_new_pie_project/database/entities/subscription/subscription_detail_entity.dart';
import 'package:floor/floor.dart';

import '../../entities/subscription/subscription_entity.dart';

@dao
abstract class SubscriptionDao {
  @insert
  Future<void> insertEntity(
    SubscriptionEntity entity,
  );

  @insert
  Future<void> insertEntities(
    List<SubscriptionEntity> entities,
  );

  @update
  Future<void> updateEntity(
    SubscriptionEntity entity,
  );

  @delete
  Future<void> deleteEntity(
    SubscriptionEntity entity,
  );

  @Query("DELETE FROM ${SubscriptionEntity.tableName} WHERE id=:id")
  Future<void> deleteById(
    int id,
  );

  @Query("SELECT * FROM ${SubscriptionEntity.tableName}")
  Future<List<SubscriptionEntity>> findAll();

  @Query("SELECT * FROM ${SubscriptionEntity.tableName}")
  Stream<List<SubscriptionEntity>> findAllAsStream();

  @Query("DELETE FROM ${SubscriptionEntity.tableName}")
  Future<void> clear();

  @Query(
      "SELECT * FROM ${SubscriptionEntity.tableName} INNER JOIN ${SubscriptionDetailEntity.tableName} ON ${SubscriptionEntity.tableName}.id = ${SubscriptionDetailEntity.tableName}.subscriptionId "
      " WHERE ${SubscriptionDetailEntity.tableName}.groupId = :groupId")
  Future<List<SubscriptionEntity>> findSubscriptionOfGroup(
    int groupId,
  );

  @Query(
      "SELECT * FROM ${SubscriptionEntity.tableName} INNER JOIN ${SubscriptionDetailEntity.tableName} ON ${SubscriptionEntity.tableName}.id = ${SubscriptionDetailEntity.tableName}.subscriptionId "
      " WHERE ${SubscriptionDetailEntity.tableName}.groupId = :groupId")
  Stream<List<SubscriptionEntity>> findSubscriptionOfGroupAsStream(
    int groupId,
  );
}
