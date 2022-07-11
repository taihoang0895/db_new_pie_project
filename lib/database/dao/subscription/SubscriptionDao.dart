import 'package:db_new_pie_project/database/entities/subscription/SubscriptionDetailEntity.dart';
import 'package:floor/floor.dart';

import '../../entities/subscription/SubscriptionEntity.dart';

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

  @Query("DELETE FROM ${SubscriptionEntity.TABLE_NAME} WHERE id=:id")
  Future<void> deleteById(
    int id,
  );

  @Query("SELECT * FROM ${SubscriptionEntity.TABLE_NAME}")
  Future<List<SubscriptionEntity>> findAll();

  @Query("SELECT * FROM ${SubscriptionEntity.TABLE_NAME}")
  Stream<List<SubscriptionEntity>> findAllAsStream();

  @Query("DELETE FROM ${SubscriptionEntity.TABLE_NAME}")
  Future<void> clear();

  @Query(
      "SELECT * FROM ${SubscriptionEntity.TABLE_NAME} INNER JOIN ${SubscriptionDetailEntity.TABLE_NAME} ON ${SubscriptionEntity.TABLE_NAME}.id = ${SubscriptionDetailEntity.TABLE_NAME}.subscriptionId "
      " WHERE ${SubscriptionDetailEntity.TABLE_NAME}.groupId = :groupId")
  Future<List<SubscriptionEntity>> findSubscriptionOfGroup(
    int groupId,
  );

  @Query(
      "SELECT * FROM ${SubscriptionEntity.TABLE_NAME} INNER JOIN ${SubscriptionDetailEntity.TABLE_NAME} ON ${SubscriptionEntity.TABLE_NAME}.id = ${SubscriptionDetailEntity.TABLE_NAME}.subscriptionId "
      " WHERE ${SubscriptionDetailEntity.TABLE_NAME}.groupId = :groupId")
  Stream<List<SubscriptionEntity>> findSubscriptionOfGroupAsStream(
    int groupId,
  );
}
