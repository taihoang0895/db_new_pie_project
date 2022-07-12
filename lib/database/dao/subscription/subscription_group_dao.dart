import 'package:db_new_pie_project/database/entities/subscription/subscription_group_entity.dart';
import 'package:floor/floor.dart';

import '../../entities/subscription/subscription_entity.dart';

@dao
abstract class SubscriptionGroupDao {
  @insert
  Future<int> insertEntity(
    SubscriptionGroupEntity entity,
  );

  @update
  Future<void> updateEntity(
    SubscriptionGroupEntity entity,
  );

  @delete
  Future<void> deleteEntity(
    SubscriptionGroupEntity entity,
  );

  @Query("DELETE FROM ${SubscriptionGroupEntity.tableName} WHERE id=:id")
  Future<void> deleteById(
    int id,
  );

  @Query("SELECT * FROM ${SubscriptionGroupEntity.tableName}")
  Future<List<SubscriptionGroupEntity>> findAll();

  @Query("SELECT * FROM ${SubscriptionGroupEntity.tableName}")
  Stream<List<SubscriptionGroupEntity>> findAllAsStream();

  @Query("DELETE FROM ${SubscriptionGroupEntity.tableName}")
  Future<void> clear();

  @Query("SELECT * FROM ${SubscriptionGroupEntity.tableName} WHERE id = :id")
  Future<SubscriptionGroupEntity?> firstOrNull(
    int id,
  );
}
