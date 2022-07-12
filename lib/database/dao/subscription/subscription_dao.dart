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
  Future<void> deleteById(String id);

  @Query("SELECT * FROM ${SubscriptionEntity.tableName}")
  Future<List<SubscriptionEntity>> findAll();

  @Query("SELECT * FROM ${SubscriptionEntity.tableName}")
  Stream<List<SubscriptionEntity>> findAllAsStream();

  @Query("DELETE FROM ${SubscriptionEntity.tableName}")
  Future<void> clear();
}
