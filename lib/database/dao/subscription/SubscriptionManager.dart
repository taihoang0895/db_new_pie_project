import 'package:db_new_pie_project/database/entities/subscription/SubscriptionDetailEntity.dart';
import 'package:db_new_pie_project/database/entities/subscription/SubscriptionGroupEntity.dart';
import 'package:floor/floor.dart';

import '../../app_database.dart';
import '../../entities/subscription/SubscriptionEntity.dart';

class SubscriptionManager {
  final AppDatabase _appDatabase;
  final QueryAdapter _queryAdapter;

  SubscriptionManager(this._appDatabase)
      : _queryAdapter = _appDatabase.buildQueryAdapter();

  Stream<List<SubscriptionGroupEntity>> findAllSubscriptionGroupAsStream() {
    return _appDatabase.subscriptionGroupDao.findAllAsStream();
  }

  Future<List<SubscriptionGroupEntity>> findAllSubscriptionGroup() {
    return _appDatabase.subscriptionGroupDao.findAll();
  }

  Future<void> saveOnlyChannelGroup(
    SubscriptionGroupEntity groupEntity,
  ) {
    final groupId = groupEntity.id;
    if (groupId == null) {
      return _appDatabase.subscriptionGroupDao.insertEntity(groupEntity);
    } else {
      return _appDatabase.subscriptionGroupDao.updateEntity(groupEntity);
    }
  }

  @transaction
  Future<void> saveChannelGroup(
    SubscriptionGroupEntity groupEntity,
    List<SubscriptionEntity> subscriptions,
  ) async {
    final groupId = groupEntity.id;
    if (groupId == null) {
      int id =
          await _appDatabase.subscriptionGroupDao.insertEntity(groupEntity);
      await _appDatabase.subscriptionDetailDao.insertEntities(subscriptions
          .map((e) => SubscriptionDetailEntity(id, e.id!))
          .toList());
    } else {
      await _appDatabase.subscriptionGroupDao.updateEntity(groupEntity);
      await _appDatabase.subscriptionDetailDao.deleteByGroupId(groupId);
      await _appDatabase.subscriptionDetailDao.insertEntities(subscriptions
          .map((e) => SubscriptionDetailEntity(groupId, e.id!))
          .toList());
    }
  }

  @transaction
  Future<void> deleteChannelGroup(
    int groupId,
  ) async {
    await _appDatabase.subscriptionDetailDao.deleteByGroupId(groupId);
    await _appDatabase.subscriptionGroupDao.deleteById(groupId).then((value) {
      _appDatabase.notifyTableChanged(SubscriptionDetailEntity.TABLE_NAME);
      _appDatabase.notifyTableChanged(SubscriptionGroupEntity.TABLE_NAME);
    });
  }

  Stream<List<SubscriptionEntity>> findSubscriptionsOfGroupAsStream(
    int groupId,
  ) {
    return _appDatabase.subscriptionDao
        .findSubscriptionOfGroupAsStream(groupId);
  }

  Future<List<SubscriptionEntity>> findSubscriptionsOfGroup(
    int groupId,
  ) {
    return _appDatabase.subscriptionDao.findSubscriptionOfGroup(groupId);
  }

  Stream<List<SubscriptionEntity>> findAllSubscriptionsAsStream() {
    return _appDatabase.subscriptionDao.findAllAsStream();
  }

  Future<List<SubscriptionEntity>> findAllSubscriptions() {
    return _appDatabase.subscriptionDao.findAll();
  }

  Future<void> insertSubscription(
    SubscriptionEntity entity,
  ) {
    return _appDatabase.subscriptionDao.insertEntity(entity);
  }

  Future<void> updateSubscription(
    SubscriptionEntity entity,
  ) {
    return _appDatabase.subscriptionDao.updateEntity(entity);
  }

  Future<void> insertSubscriptions(
    List<SubscriptionEntity> entities,
  ) {
    return _appDatabase.subscriptionDao.insertEntities(entities);
  }

  Future<void> deleteSubscription(
    SubscriptionEntity entity,
  ) {
    return _appDatabase.subscriptionDao.deleteEntity(entity);
  }

  Future<void> deleteSubscriptionById(
    int id,
  ) {
    return _appDatabase.subscriptionDao.deleteById(id).then((value) =>
        _appDatabase.notifyTableChanged(SubscriptionEntity.TABLE_NAME));
  }
}
