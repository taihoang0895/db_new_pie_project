import 'package:db_new_pie_project/database/entities/subscription/SubscriptionGroupEntity.dart';
import 'package:floor/floor.dart';

import '../../entities/subscription/SubscriptionEntity.dart';

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

  @Query("DELETE FROM ${SubscriptionGroupEntity.TABLE_NAME} WHERE id=:id")
  Future<void> deleteById(
    int id,
  );

  @Query("SELECT * FROM ${SubscriptionGroupEntity.TABLE_NAME}")
  Future<List<SubscriptionGroupEntity>> findAll();

  @Query("SELECT * FROM ${SubscriptionGroupEntity.TABLE_NAME}")
  Stream<List<SubscriptionGroupEntity>> findAllAsStream();

  @Query("DELETE FROM ${SubscriptionGroupEntity.TABLE_NAME}")
  Future<void> clear();

  @Query("SELECT * FROM ${SubscriptionGroupEntity.TABLE_NAME} WHERE id = :id")
  Future<SubscriptionGroupEntity?> firstOrNull(
    int id,
  );
}
