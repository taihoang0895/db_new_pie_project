// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  SearchHistoryDao? _historyDaoInstance;

  StreamDao? _streamDaoInstance;

  SubscriptionDao? _subscriptionDaoInstance;

  SubscriptionDetailDao? _subscriptionDetailDaoInstance;

  SubscriptionGroupDao? _subscriptionGroupDaoInstance;

  PlaylistDao? _playListDaoInstance;

  PlayListDetailsDao? _detailsDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SearchHistory` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `search` TEXT NOT NULL, `creationDate` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Stream` (`uid` TEXT NOT NULL, `url` TEXT NOT NULL, `tile` TEXT NOT NULL, `streamType` TEXT NOT NULL, `duration` INTEGER NOT NULL, `uploader` TEXT NOT NULL, `uploaderUrl` TEXT NOT NULL, `viewCount` INTEGER NOT NULL, `textualUploadDate` TEXT NOT NULL, `uploadDate` INTEGER NOT NULL, PRIMARY KEY (`uid`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `History` (`streamId` INTEGER NOT NULL, `accessDate` INTEGER NOT NULL, `repeatCount` INTEGER NOT NULL, PRIMARY KEY (`streamId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `StreamState` (`streamId` TEXT NOT NULL, `progressTime` INTEGER NOT NULL, PRIMARY KEY (`streamId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Subscription` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `url` TEXT NOT NULL, `name` TEXT NOT NULL, `avatarUrl` TEXT NOT NULL, `subscriberCount` INTEGER NOT NULL, `description` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SubscriptionGroup` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `iconId` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SubscriptionDetail` (`groupId` INTEGER NOT NULL, `subscriptionId` INTEGER NOT NULL, PRIMARY KEY (`groupId`, `subscriptionId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Playlist` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `name` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PlaylistDetail` (`playlistId` INTEGER NOT NULL, `streamId` TEXT NOT NULL, `joinIndex` INTEGER NOT NULL, PRIMARY KEY (`playlistId`, `streamId`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  SearchHistoryDao get historyDao {
    return _historyDaoInstance ??= _$SearchHistoryDao(database, changeListener);
  }

  @override
  StreamDao get streamDao {
    return _streamDaoInstance ??= _$StreamDao(database, changeListener);
  }

  @override
  SubscriptionDao get subscriptionDao {
    return _subscriptionDaoInstance ??=
        _$SubscriptionDao(database, changeListener);
  }

  @override
  SubscriptionDetailDao get subscriptionDetailDao {
    return _subscriptionDetailDaoInstance ??=
        _$SubscriptionDetailDao(database, changeListener);
  }

  @override
  SubscriptionGroupDao get subscriptionGroupDao {
    return _subscriptionGroupDaoInstance ??=
        _$SubscriptionGroupDao(database, changeListener);
  }

  @override
  PlaylistDao get playListDao {
    return _playListDaoInstance ??= _$PlaylistDao(database, changeListener);
  }

  @override
  PlayListDetailsDao get detailsDao {
    return _detailsDaoInstance ??=
        _$PlayListDetailsDao(database, changeListener);
  }
}

class _$SearchHistoryDao extends SearchHistoryDao {
  _$SearchHistoryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _searchHistoryEntityInsertionAdapter = InsertionAdapter(
            database,
            'SearchHistory',
            (SearchHistoryEntity item) => <String, Object?>{
                  'id': item.id,
                  'search': item.search,
                  'creationDate': item.creationDate
                },
            changeListener),
        _streamHistoryEntityInsertionAdapter = InsertionAdapter(
            database,
            'History',
            (StreamHistoryEntity item) => <String, Object?>{
                  'streamId': item.streamId,
                  'accessDate': item.accessDate,
                  'repeatCount': item.repeatCount
                },
            changeListener),
        _streamStateEntityInsertionAdapter = InsertionAdapter(
            database,
            'StreamState',
            (StreamStateEntity item) => <String, Object?>{
                  'streamId': item.streamId,
                  'progressTime': item.progressTime
                }),
        _searchHistoryEntityUpdateAdapter = UpdateAdapter(
            database,
            'SearchHistory',
            ['id'],
            (SearchHistoryEntity item) => <String, Object?>{
                  'id': item.id,
                  'search': item.search,
                  'creationDate': item.creationDate
                },
            changeListener),
        _streamHistoryEntityUpdateAdapter = UpdateAdapter(
            database,
            'History',
            ['streamId'],
            (StreamHistoryEntity item) => <String, Object?>{
                  'streamId': item.streamId,
                  'accessDate': item.accessDate,
                  'repeatCount': item.repeatCount
                },
            changeListener),
        _streamStateEntityUpdateAdapter = UpdateAdapter(
            database,
            'StreamState',
            ['streamId'],
            (StreamStateEntity item) => <String, Object?>{
                  'streamId': item.streamId,
                  'progressTime': item.progressTime
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SearchHistoryEntity>
      _searchHistoryEntityInsertionAdapter;

  final InsertionAdapter<StreamHistoryEntity>
      _streamHistoryEntityInsertionAdapter;

  final InsertionAdapter<StreamStateEntity> _streamStateEntityInsertionAdapter;

  final UpdateAdapter<SearchHistoryEntity> _searchHistoryEntityUpdateAdapter;

  final UpdateAdapter<StreamHistoryEntity> _streamHistoryEntityUpdateAdapter;

  final UpdateAdapter<StreamStateEntity> _streamStateEntityUpdateAdapter;

  @override
  Future<List<SearchHistoryEntity>> findAll() async {
    return _queryAdapter.queryList(
        'SELECT * FROM SearchHistory order by creationDate DESC',
        mapper: (Map<String, Object?> row) => SearchHistoryEntity(
            row['id'] as int?,
            row['search'] as String,
            row['creationDate'] as int));
  }

  @override
  Stream<List<SearchHistoryEntity>> findAllAsStream() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM SearchHistory order by creationDate DESC',
        mapper: (Map<String, Object?> row) => SearchHistoryEntity(
            row['id'] as int?,
            row['search'] as String,
            row['creationDate'] as int),
        queryableName: 'SearchHistory',
        isView: false);
  }

  @override
  Future<void> clearSearchHistory() async {
    await _queryAdapter.queryNoReturn('DELETE FROM SearchHistory');
  }

  @override
  Future<void> deleteSearchHistory(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM SearchHistory WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<SearchHistoryEntity?> firstOrNull(String text) async {
    return _queryAdapter.query(
        'SELECT *  FROM SearchHistory WHERE search = ?1 LIMIT 1',
        mapper: (Map<String, Object?> row) => SearchHistoryEntity(
            row['id'] as int?,
            row['search'] as String,
            row['creationDate'] as int),
        arguments: [text]);
  }

  @override
  Stream<List<SearchHistoryEntity>> findSimilarText(String text, int limit) {
    return _queryAdapter.queryListStream(
        'SELECT *  FROM SearchHistory WHERE search LIKE ?1 || \'%\' order by creationDate DESC LIMIT ?2',
        mapper: (Map<String, Object?> row) => SearchHistoryEntity(
            row['id'] as int?,
            row['search'] as String,
            row['creationDate'] as int),
        arguments: [text, limit],
        queryableName: 'SearchHistory',
        isView: false);
  }

  @override
  Future<StreamHistoryEntity?> firstOrNullStreamHistory(int streamId) async {
    return _queryAdapter.query(
        'SELECT * FROM History WHERE streamId = ?1 LIMIT 1',
        mapper: (Map<String, Object?> row) => StreamHistoryEntity(
            row['streamId'] as int,
            row['accessDate'] as int,
            row['repeatCount'] as int),
        arguments: [streamId]);
  }

  @override
  Future<List<StreamHistoryEntity>> findAllStreamHistoryEntities() async {
    return _queryAdapter.queryList(
        'SELECT * FROM History ORDER BY accessDate DESC',
        mapper: (Map<String, Object?> row) => StreamHistoryEntity(
            row['streamId'] as int,
            row['accessDate'] as int,
            row['repeatCount'] as int));
  }

  @override
  Stream<List<StreamHistoryEntity>> findAllStreamHistoryEntitiesAsStream() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM History order by accessDate DESC',
        mapper: (Map<String, Object?> row) => StreamHistoryEntity(
            row['streamId'] as int,
            row['accessDate'] as int,
            row['repeatCount'] as int),
        queryableName: 'History',
        isView: false);
  }

  @override
  Future<void> deleteStreamHistory(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM History WHERE streamId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> clearStreamHistory() async {
    await _queryAdapter.queryNoReturn('DELETE FROM History');
  }

  @override
  Future<StreamStateEntity?> firstOrNullStreamState(String streamId) async {
    return _queryAdapter.query('SELECT * FROM StreamState WHERE streamId = ?1',
        mapper: (Map<String, Object?> row) => StreamStateEntity(
            row['streamId'] as String, row['progressTime'] as int),
        arguments: [streamId]);
  }

  @override
  Future<void> insertSearchHistory(SearchHistoryEntity entity) async {
    await _searchHistoryEntityInsertionAdapter.insert(
        entity, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertStreamHistory(StreamHistoryEntity entity) async {
    await _streamHistoryEntityInsertionAdapter.insert(
        entity, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertStreamStateEntity(StreamStateEntity entity) async {
    await _streamStateEntityInsertionAdapter.insert(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateSearchHistory(SearchHistoryEntity entity) async {
    await _searchHistoryEntityUpdateAdapter.update(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateStreamHistory(StreamHistoryEntity entity) async {
    await _streamHistoryEntityUpdateAdapter.update(
        entity, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateStreamStateEntity(StreamStateEntity entity) async {
    await _streamStateEntityUpdateAdapter.update(
        entity, OnConflictStrategy.abort);
  }
}

class _$StreamDao extends StreamDao {
  _$StreamDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _streamEntityInsertionAdapter = InsertionAdapter(
            database,
            'Stream',
            (StreamEntity item) => <String, Object?>{
                  'uid': item.uid,
                  'url': item.url,
                  'tile': item.tile,
                  'streamType': item.streamType,
                  'duration': item.duration,
                  'uploader': item.uploader,
                  'uploaderUrl': item.uploaderUrl,
                  'viewCount': item.viewCount,
                  'textualUploadDate': item.textualUploadDate,
                  'uploadDate': item.uploadDate
                },
            changeListener),
        _streamEntityUpdateAdapter = UpdateAdapter(
            database,
            'Stream',
            ['uid'],
            (StreamEntity item) => <String, Object?>{
                  'uid': item.uid,
                  'url': item.url,
                  'tile': item.tile,
                  'streamType': item.streamType,
                  'duration': item.duration,
                  'uploader': item.uploader,
                  'uploaderUrl': item.uploaderUrl,
                  'viewCount': item.viewCount,
                  'textualUploadDate': item.textualUploadDate,
                  'uploadDate': item.uploadDate
                },
            changeListener),
        _streamEntityDeletionAdapter = DeletionAdapter(
            database,
            'Stream',
            ['uid'],
            (StreamEntity item) => <String, Object?>{
                  'uid': item.uid,
                  'url': item.url,
                  'tile': item.tile,
                  'streamType': item.streamType,
                  'duration': item.duration,
                  'uploader': item.uploader,
                  'uploaderUrl': item.uploaderUrl,
                  'viewCount': item.viewCount,
                  'textualUploadDate': item.textualUploadDate,
                  'uploadDate': item.uploadDate
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<StreamEntity> _streamEntityInsertionAdapter;

  final UpdateAdapter<StreamEntity> _streamEntityUpdateAdapter;

  final DeletionAdapter<StreamEntity> _streamEntityDeletionAdapter;

  @override
  Future<void> deleteStreamById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM Stream WHERE uid = ?1', arguments: [id]);
  }

  @override
  Stream<List<StreamEntity>> findAllAsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM Stream',
        mapper: (Map<String, Object?> row) => StreamEntity(
            row['uid'] as String,
            row['url'] as String,
            row['tile'] as String,
            row['streamType'] as String,
            row['duration'] as int,
            row['uploader'] as String,
            row['uploaderUrl'] as String,
            row['viewCount'] as int,
            row['textualUploadDate'] as String,
            row['uploadDate'] as int),
        queryableName: 'Stream',
        isView: false);
  }

  @override
  Stream<StreamEntity?> findByIdAsStream(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Stream WHERE uid = ?1',
        mapper: (Map<String, Object?> row) => StreamEntity(
            row['uid'] as String,
            row['url'] as String,
            row['tile'] as String,
            row['streamType'] as String,
            row['duration'] as int,
            row['uploader'] as String,
            row['uploaderUrl'] as String,
            row['viewCount'] as int,
            row['textualUploadDate'] as String,
            row['uploadDate'] as int),
        arguments: [id],
        queryableName: 'Stream',
        isView: false);
  }

  @override
  Future<StreamEntity?> findById(int id) async {
    return _queryAdapter.query('SELECT * FROM Stream WHERE uid = ?1',
        mapper: (Map<String, Object?> row) => StreamEntity(
            row['uid'] as String,
            row['url'] as String,
            row['tile'] as String,
            row['streamType'] as String,
            row['duration'] as int,
            row['uploader'] as String,
            row['uploaderUrl'] as String,
            row['viewCount'] as int,
            row['textualUploadDate'] as String,
            row['uploadDate'] as int),
        arguments: [id]);
  }

  @override
  Future<List<StreamEntity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM Stream',
        mapper: (Map<String, Object?> row) => StreamEntity(
            row['uid'] as String,
            row['url'] as String,
            row['tile'] as String,
            row['streamType'] as String,
            row['duration'] as int,
            row['uploader'] as String,
            row['uploaderUrl'] as String,
            row['viewCount'] as int,
            row['textualUploadDate'] as String,
            row['uploadDate'] as int));
  }

  @override
  Future<void> clear() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Stream');
  }

  @override
  Future<void> insertStream(StreamEntity entity) async {
    await _streamEntityInsertionAdapter.insert(
        entity, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertStreams(List<StreamEntity> entities) async {
    await _streamEntityInsertionAdapter.insertList(
        entities, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateStream(StreamEntity entity) async {
    await _streamEntityUpdateAdapter.update(entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteStream(StreamEntity entity) async {
    await _streamEntityDeletionAdapter.delete(entity);
  }
}

class _$SubscriptionDao extends SubscriptionDao {
  _$SubscriptionDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _subscriptionEntityInsertionAdapter = InsertionAdapter(
            database,
            'Subscription',
            (SubscriptionEntity item) => <String, Object?>{
                  'id': item.id,
                  'url': item.url,
                  'name': item.name,
                  'avatarUrl': item.avatarUrl,
                  'subscriberCount': item.subscriberCount,
                  'description': item.description
                },
            changeListener),
        _subscriptionEntityUpdateAdapter = UpdateAdapter(
            database,
            'Subscription',
            ['id'],
            (SubscriptionEntity item) => <String, Object?>{
                  'id': item.id,
                  'url': item.url,
                  'name': item.name,
                  'avatarUrl': item.avatarUrl,
                  'subscriberCount': item.subscriberCount,
                  'description': item.description
                },
            changeListener),
        _subscriptionEntityDeletionAdapter = DeletionAdapter(
            database,
            'Subscription',
            ['id'],
            (SubscriptionEntity item) => <String, Object?>{
                  'id': item.id,
                  'url': item.url,
                  'name': item.name,
                  'avatarUrl': item.avatarUrl,
                  'subscriberCount': item.subscriberCount,
                  'description': item.description
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SubscriptionEntity>
      _subscriptionEntityInsertionAdapter;

  final UpdateAdapter<SubscriptionEntity> _subscriptionEntityUpdateAdapter;

  final DeletionAdapter<SubscriptionEntity> _subscriptionEntityDeletionAdapter;

  @override
  Future<void> deleteById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM Subscription WHERE id=?1', arguments: [id]);
  }

  @override
  Future<List<SubscriptionEntity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM Subscription',
        mapper: (Map<String, Object?> row) => SubscriptionEntity(
            row['id'] as int?,
            row['url'] as String,
            row['name'] as String,
            row['avatarUrl'] as String,
            row['subscriberCount'] as int,
            row['description'] as String));
  }

  @override
  Stream<List<SubscriptionEntity>> findAllAsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM Subscription',
        mapper: (Map<String, Object?> row) => SubscriptionEntity(
            row['id'] as int?,
            row['url'] as String,
            row['name'] as String,
            row['avatarUrl'] as String,
            row['subscriberCount'] as int,
            row['description'] as String),
        queryableName: 'Subscription',
        isView: false);
  }

  @override
  Future<void> clear() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Subscription');
  }

  @override
  Future<List<SubscriptionEntity>> findSubscriptionOfGroup(int groupId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Subscription INNER JOIN SubscriptionDetail ON Subscription.id = SubscriptionDetail.subscriptionId  WHERE SubscriptionDetail.groupId = ?1',
        mapper: (Map<String, Object?> row) => SubscriptionEntity(row['id'] as int?, row['url'] as String, row['name'] as String, row['avatarUrl'] as String, row['subscriberCount'] as int, row['description'] as String),
        arguments: [groupId]);
  }

  @override
  Stream<List<SubscriptionEntity>> findSubscriptionOfGroupAsStream(
      int groupId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Subscription INNER JOIN SubscriptionDetail ON Subscription.id = SubscriptionDetail.subscriptionId  WHERE SubscriptionDetail.groupId = ?1',
        mapper: (Map<String, Object?> row) => SubscriptionEntity(
            row['id'] as int?,
            row['url'] as String,
            row['name'] as String,
            row['avatarUrl'] as String,
            row['subscriberCount'] as int,
            row['description'] as String),
        arguments: [groupId],
        queryableName: 'Subscription',
        isView: false);
  }

  @override
  Future<void> insertEntity(SubscriptionEntity entity) async {
    await _subscriptionEntityInsertionAdapter.insert(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertEntities(List<SubscriptionEntity> entities) async {
    await _subscriptionEntityInsertionAdapter.insertList(
        entities, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateEntity(SubscriptionEntity entity) async {
    await _subscriptionEntityUpdateAdapter.update(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteEntity(SubscriptionEntity entity) async {
    await _subscriptionEntityDeletionAdapter.delete(entity);
  }
}

class _$SubscriptionDetailDao extends SubscriptionDetailDao {
  _$SubscriptionDetailDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _subscriptionDetailEntityInsertionAdapter = InsertionAdapter(
            database,
            'SubscriptionDetail',
            (SubscriptionDetailEntity item) => <String, Object?>{
                  'groupId': item.groupId,
                  'subscriptionId': item.subscriptionId
                },
            changeListener),
        _subscriptionDetailEntityUpdateAdapter = UpdateAdapter(
            database,
            'SubscriptionDetail',
            ['groupId', 'subscriptionId'],
            (SubscriptionDetailEntity item) => <String, Object?>{
                  'groupId': item.groupId,
                  'subscriptionId': item.subscriptionId
                },
            changeListener),
        _subscriptionDetailEntityDeletionAdapter = DeletionAdapter(
            database,
            'SubscriptionDetail',
            ['groupId', 'subscriptionId'],
            (SubscriptionDetailEntity item) => <String, Object?>{
                  'groupId': item.groupId,
                  'subscriptionId': item.subscriptionId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SubscriptionDetailEntity>
      _subscriptionDetailEntityInsertionAdapter;

  final UpdateAdapter<SubscriptionDetailEntity>
      _subscriptionDetailEntityUpdateAdapter;

  final DeletionAdapter<SubscriptionDetailEntity>
      _subscriptionDetailEntityDeletionAdapter;

  @override
  Future<void> deleteById(int groupId, int subscriptionId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM SubscriptionDetail WHERE groupId = ?1 AND subscriptionId = ?2',
        arguments: [groupId, subscriptionId]);
  }

  @override
  Future<void> deleteByGroupId(int groupId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM SubscriptionDetail WHERE groupId = ?1',
        arguments: [groupId]);
  }

  @override
  Future<List<SubscriptionDetailEntity>> findByGroupId(int groupId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM SubscriptionDetail WHERE groupId = ?1',
        mapper: (Map<String, Object?> row) => SubscriptionDetailEntity(
            row['groupId'] as int, row['subscriptionId'] as int),
        arguments: [groupId]);
  }

  @override
  Future<List<SubscriptionDetailEntity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM SubscriptionDetail',
        mapper: (Map<String, Object?> row) => SubscriptionDetailEntity(
            row['groupId'] as int, row['subscriptionId'] as int));
  }

  @override
  Stream<List<SubscriptionDetailEntity>> findAllAsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM SubscriptionDetail',
        mapper: (Map<String, Object?> row) => SubscriptionDetailEntity(
            row['groupId'] as int, row['subscriptionId'] as int),
        queryableName: 'SubscriptionDetail',
        isView: false);
  }

  @override
  Future<void> clear() async {
    await _queryAdapter.queryNoReturn('DELETE FROM SubscriptionDetail');
  }

  @override
  Future<void> insertEntity(SubscriptionDetailEntity entity) async {
    await _subscriptionDetailEntityInsertionAdapter.insert(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertEntities(List<SubscriptionDetailEntity> entities) async {
    await _subscriptionDetailEntityInsertionAdapter.insertList(
        entities, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateEntity(SubscriptionDetailEntity entity) async {
    await _subscriptionDetailEntityUpdateAdapter.update(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteEntity(SubscriptionDetailEntity entity) async {
    await _subscriptionDetailEntityDeletionAdapter.delete(entity);
  }
}

class _$SubscriptionGroupDao extends SubscriptionGroupDao {
  _$SubscriptionGroupDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _subscriptionGroupEntityInsertionAdapter = InsertionAdapter(
            database,
            'SubscriptionGroup',
            (SubscriptionGroupEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'iconId': item.iconId
                },
            changeListener),
        _subscriptionGroupEntityUpdateAdapter = UpdateAdapter(
            database,
            'SubscriptionGroup',
            ['id'],
            (SubscriptionGroupEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'iconId': item.iconId
                },
            changeListener),
        _subscriptionGroupEntityDeletionAdapter = DeletionAdapter(
            database,
            'SubscriptionGroup',
            ['id'],
            (SubscriptionGroupEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'iconId': item.iconId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SubscriptionGroupEntity>
      _subscriptionGroupEntityInsertionAdapter;

  final UpdateAdapter<SubscriptionGroupEntity>
      _subscriptionGroupEntityUpdateAdapter;

  final DeletionAdapter<SubscriptionGroupEntity>
      _subscriptionGroupEntityDeletionAdapter;

  @override
  Future<void> deleteById(int id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM SubscriptionGroup WHERE id=?1',
        arguments: [id]);
  }

  @override
  Future<List<SubscriptionGroupEntity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM SubscriptionGroup',
        mapper: (Map<String, Object?> row) => SubscriptionGroupEntity(
            row['id'] as int?, row['name'] as String, row['iconId'] as int));
  }

  @override
  Stream<List<SubscriptionGroupEntity>> findAllAsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM SubscriptionGroup',
        mapper: (Map<String, Object?> row) => SubscriptionGroupEntity(
            row['id'] as int?, row['name'] as String, row['iconId'] as int),
        queryableName: 'SubscriptionGroup',
        isView: false);
  }

  @override
  Future<void> clear() async {
    await _queryAdapter.queryNoReturn('DELETE FROM SubscriptionGroup');
  }

  @override
  Future<SubscriptionGroupEntity?> firstOrNull(int id) async {
    return _queryAdapter.query('SELECT * FROM SubscriptionGroup WHERE id = ?1',
        mapper: (Map<String, Object?> row) => SubscriptionGroupEntity(
            row['id'] as int?, row['name'] as String, row['iconId'] as int),
        arguments: [id]);
  }

  @override
  Future<int> insertEntity(SubscriptionGroupEntity entity) {
    return _subscriptionGroupEntityInsertionAdapter.insertAndReturnId(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateEntity(SubscriptionGroupEntity entity) async {
    await _subscriptionGroupEntityUpdateAdapter.update(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteEntity(SubscriptionGroupEntity entity) async {
    await _subscriptionGroupEntityDeletionAdapter.delete(entity);
  }
}

class _$PlaylistDao extends PlaylistDao {
  _$PlaylistDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _playlistEntityInsertionAdapter = InsertionAdapter(
            database,
            'Playlist',
            (PlaylistEntity item) =>
                <String, Object?>{'id': item.id, 'name': item.name},
            changeListener),
        _playlistEntityUpdateAdapter = UpdateAdapter(
            database,
            'Playlist',
            ['id'],
            (PlaylistEntity item) =>
                <String, Object?>{'id': item.id, 'name': item.name},
            changeListener),
        _playlistEntityDeletionAdapter = DeletionAdapter(
            database,
            'Playlist',
            ['id'],
            (PlaylistEntity item) =>
                <String, Object?>{'id': item.id, 'name': item.name},
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PlaylistEntity> _playlistEntityInsertionAdapter;

  final UpdateAdapter<PlaylistEntity> _playlistEntityUpdateAdapter;

  final DeletionAdapter<PlaylistEntity> _playlistEntityDeletionAdapter;

  @override
  Stream<List<PlaylistEntity>> findAllAsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM Playlist',
        mapper: (Map<String, Object?> row) =>
            PlaylistEntity(row['id'] as int, row['name'] as String),
        queryableName: 'Playlist',
        isView: false);
  }

  @override
  Future<List<PlaylistEntity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM Playlist',
        mapper: (Map<String, Object?> row) =>
            PlaylistEntity(row['id'] as int, row['name'] as String));
  }

  @override
  Future<PlaylistEntity?> findPlayListByID(int playListID) async {
    return _queryAdapter.query('SELECT * FROM Playlist WHERE Playlist.id = ?1',
        mapper: (Map<String, Object?> row) =>
            PlaylistEntity(row['id'] as int, row['name'] as String),
        arguments: [playListID]);
  }

  @override
  Future<void> deletePlayListByID(int playListId) async {
    await _queryAdapter.queryNoReturn('DELETE FROM Playlist WHERE id = ?1',
        arguments: [playListId]);
  }

  @override
  Future<void> clearPLayList() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Playlist');
  }

  @override
  Future<void> addPlaylist(PlaylistEntity playList) async {
    await _playlistEntityInsertionAdapter.insert(
        playList, OnConflictStrategy.replace);
  }

  @override
  Future<int> renamePlayList(PlaylistEntity playlistEntity) {
    return _playlistEntityUpdateAdapter.updateAndReturnChangedRows(
        playlistEntity, OnConflictStrategy.abort);
  }

  @override
  Future<int> deletePlayList(PlaylistEntity playlistEntity) {
    return _playlistEntityDeletionAdapter
        .deleteAndReturnChangedRows(playlistEntity);
  }
}

class _$PlayListDetailsDao extends PlayListDetailsDao {
  _$PlayListDetailsDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _playlistDetailEntityInsertionAdapter = InsertionAdapter(
            database,
            'PlaylistDetail',
            (PlaylistDetailEntity item) => <String, Object?>{
                  'playlistId': item.playlistId,
                  'streamId': item.streamId,
                  'joinIndex': item.joinIndex
                },
            changeListener),
        _playlistDetailEntityUpdateAdapter = UpdateAdapter(
            database,
            'PlaylistDetail',
            ['playlistId', 'streamId'],
            (PlaylistDetailEntity item) => <String, Object?>{
                  'playlistId': item.playlistId,
                  'streamId': item.streamId,
                  'joinIndex': item.joinIndex
                },
            changeListener),
        _playlistDetailEntityDeletionAdapter = DeletionAdapter(
            database,
            'PlaylistDetail',
            ['playlistId', 'streamId'],
            (PlaylistDetailEntity item) => <String, Object?>{
                  'playlistId': item.playlistId,
                  'streamId': item.streamId,
                  'joinIndex': item.joinIndex
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PlaylistDetailEntity>
      _playlistDetailEntityInsertionAdapter;

  final UpdateAdapter<PlaylistDetailEntity> _playlistDetailEntityUpdateAdapter;

  final DeletionAdapter<PlaylistDetailEntity>
      _playlistDetailEntityDeletionAdapter;

  @override
  Future<void> deletePlayListDetailById(int playListId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM PlaylistDetail WHERE PlaylistDetail.playlistId = ?1',
        arguments: [playListId]);
  }

  @override
  Future<List<PlaylistDetailEntity>> getStreamFromPlayList(
      int playListId) async {
    return _queryAdapter.queryList(
        'SELECT pl.*,st.*,sst.* FROM Playlist pl INNER JOIN PlaylistDetail dt ON pl.id = dt.playlistId INNER JOIN Stream st ON st.uid = dt.streamId INNER JOIN StreamState sst ON st.uid = sst.streamId WHERE pl.id = ?1 ORDER BY dt.joinIndex ASC',
        mapper: (Map<String, Object?> row) => PlaylistDetailEntity(playlistId: row['playlistId'] as int, streamId: row['streamId'] as String, joinIndex: row['joinIndex'] as int),
        arguments: [playListId]);
  }

  @override
  Future<List<PlaylistDetailEntity>> getPlayListDetail(int playListId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM PlaylistDetail p WHERE p.playlistId = ?1',
        mapper: (Map<String, Object?> row) => PlaylistDetailEntity(
            playlistId: row['playlistId'] as int,
            streamId: row['streamId'] as String,
            joinIndex: row['joinIndex'] as int),
        arguments: [playListId]);
  }

  @override
  Future<void> deleteStreamFromPlayList(int playListId, String streamId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM PlaylistDetail WHERE PlaylistDetail.playlistId = ?1 AND PlaylistDetail.streamId = ?2',
        arguments: [playListId, streamId]);
  }

  @override
  Future<void> clearDetails() async {
    await _queryAdapter.queryNoReturn('DELETE FROM PlaylistDetail');
  }

  @override
  Future<List<PlaylistDetailEntity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM PlaylistDetail',
        mapper: (Map<String, Object?> row) => PlaylistDetailEntity(
            playlistId: row['playlistId'] as int,
            streamId: row['streamId'] as String,
            joinIndex: row['joinIndex'] as int));
  }

  @override
  Stream<List<PlaylistDetailEntity>> findAllAsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM PlaylistDetail',
        mapper: (Map<String, Object?> row) => PlaylistDetailEntity(
            playlistId: row['playlistId'] as int,
            streamId: row['streamId'] as String,
            joinIndex: row['joinIndex'] as int),
        queryableName: 'PlaylistDetail',
        isView: false);
  }

  @override
  Future<void> addPlaylistDetail(PlaylistDetailEntity detailEntity) async {
    await _playlistDetailEntityInsertionAdapter.insert(
        detailEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> updatePlayListDetail(PlaylistDetailEntity detailEntity) async {
    await _playlistDetailEntityUpdateAdapter.update(
        detailEntity, OnConflictStrategy.abort);
  }

  @override
  Future<int> deletePlayListDetail(PlaylistDetailEntity detailEntity) {
    return _playlistDetailEntityDeletionAdapter
        .deleteAndReturnChangedRows(detailEntity);
  }
}
