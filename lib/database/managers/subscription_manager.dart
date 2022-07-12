import 'package:floor/floor.dart';

import '../app_database.dart';
import '../entities/subscription/subscription_entity.dart';

class SubscriptionManager {
  final AppDatabase _appDatabase;

  SubscriptionManager(this._appDatabase);

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
    String id,
  ) {
    return _appDatabase.subscriptionDao.deleteById(id).then((value) =>
        _appDatabase.notifyTableChanged(SubscriptionEntity.tableName));
  }
}
