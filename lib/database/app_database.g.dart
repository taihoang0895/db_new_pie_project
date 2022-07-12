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

  HistoryDao? _historyDaoInstance;

  StreamDao? _streamDaoInstance;

  SubscriptionDao? _subscriptionDaoInstance;

  PlaylistDao? _playListDaoInstance;

  PlayListDetailsDao? _detailsDaoInstance;

  SearchHistoryDao? _searchHistoryDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `SearchHistory` (`search` TEXT NOT NULL, `creationDate` INTEGER NOT NULL, PRIMARY KEY (`search`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Stream` (`uid` TEXT NOT NULL, `url` TEXT NOT NULL, `tile` TEXT NOT NULL, `streamType` TEXT NOT NULL, `duration` INTEGER NOT NULL, `uploader` TEXT NOT NULL, `uploaderUrl` TEXT NOT NULL, `viewCount` INTEGER NOT NULL, `textualUploadDate` TEXT NOT NULL, `uploadDate` INTEGER NOT NULL, PRIMARY KEY (`uid`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `History` (`streamId` TEXT NOT NULL, `accessDate` INTEGER NOT NULL, `repeatCount` INTEGER NOT NULL, PRIMARY KEY (`streamId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `StreamState` (`streamId` TEXT NOT NULL, `progressTime` INTEGER NOT NULL, PRIMARY KEY (`streamId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Subscription` (`id` TEXT NOT NULL, `url` TEXT NOT NULL, `name` TEXT NOT NULL, `avatarUrl` TEXT NOT NULL, `subscriberCount` INTEGER NOT NULL, `description` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Playlist` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `name` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PlaylistDetail` (`playlistId` INTEGER NOT NULL, `streamId` INTEGER NOT NULL, `joinIndex` INTEGER NOT NULL, PRIMARY KEY (`playlistId`, `streamId`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  HistoryDao get historyDao {
    return _historyDaoInstance ??= _$HistoryDao(database, changeListener);
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
  PlaylistDao get playListDao {
    return _playListDaoInstance ??= _$PlaylistDao(database, changeListener);
  }

  @override
  PlayListDetailsDao get detailsDao {
    return _detailsDaoInstance ??=
        _$PlayListDetailsDao(database, changeListener);
  }

  @override
  SearchHistoryDao get searchHistoryDao {
    return _searchHistoryDaoInstance ??=
        _$SearchHistoryDao(database, changeListener);
  }
}

class _$HistoryDao extends HistoryDao {
  _$HistoryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
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
        _streamHistoryEntityUpdateAdapter = UpdateAdapter(
            database,
            'History',
            ['streamId'],
            (StreamHistoryEntity item) => <String, Object?>{
                  'streamId': item.streamId,
                  'accessDate': item.accessDate,
                  'repeatCount': item.repeatCount
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<StreamHistoryEntity>
      _streamHistoryEntityInsertionAdapter;

  final InsertionAdapter<StreamStateEntity> _streamStateEntityInsertionAdapter;

  final UpdateAdapter<StreamHistoryEntity> _streamHistoryEntityUpdateAdapter;

  @override
  Future<StreamHistoryEntity?> firstOrNullStreamHistory(String streamId) async {
    return _queryAdapter.query(
        'SELECT * FROM History WHERE streamId = ?1 LIMIT 1',
        mapper: (Map<String, Object?> row) => StreamHistoryEntity(
            row['streamId'] as String,
            row['accessDate'] as int,
            row['repeatCount'] as int),
        arguments: [streamId]);
  }

  @override
  Future<List<StreamHistoryEntity>> findAllStreamHistoryEntities() async {
    return _queryAdapter.queryList(
        'SELECT * FROM History ORDER BY accessDate DESC',
        mapper: (Map<String, Object?> row) => StreamHistoryEntity(
            row['streamId'] as String,
            row['accessDate'] as int,
            row['repeatCount'] as int));
  }

  @override
  Stream<List<StreamHistoryEntity>> findAllStreamHistoryEntitiesAsStream() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM History order by accessDate DESC',
        mapper: (Map<String, Object?> row) => StreamHistoryEntity(
            row['streamId'] as String,
            row['accessDate'] as int,
            row['repeatCount'] as int),
        queryableName: 'History',
        isView: false);
  }

  @override
  Future<void> deleteStreamHistory(String id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM History WHERE streamId = ?1',
        arguments: [id]);
  }

  @override
  Future<void> clear() async {
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
  Future<StreamStateEntity?> findStreamStateById(String streamId) async {
    return _queryAdapter.query('SELECT * FROM StreamState WHERE streamId = ?1',
        mapper: (Map<String, Object?> row) => StreamStateEntity(
            row['streamId'] as String, row['progressTime'] as int),
        arguments: [streamId]);
  }

  @override
  Future<void> clearStreamState() async {
    await _queryAdapter.queryNoReturn('DELETE FROM StreamState');
  }

  @override
  Future<void> insertStreamHistory(StreamHistoryEntity entity) async {
    await _streamHistoryEntityInsertionAdapter.insert(
        entity, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertStreamStateEntity(StreamStateEntity entity) async {
    await _streamStateEntityInsertionAdapter.insert(
        entity, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateStreamHistory(StreamHistoryEntity entity) async {
    await _streamHistoryEntityUpdateAdapter.update(
        entity, OnConflictStrategy.replace);
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
  Future<void> deleteStreamById(String id) async {
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
  Stream<StreamEntity?> findByIdAsStream(String id) {
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
  Future<void> deleteById(String id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM Subscription WHERE id=?1', arguments: [id]);
  }

  @override
  Future<List<SubscriptionEntity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM Subscription',
        mapper: (Map<String, Object?> row) => SubscriptionEntity(
            row['id'] as String,
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
            row['id'] as String,
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
  Future<List<StreamStateEntity>> getStreamFromPlayList(int playListId) async {
    return _queryAdapter.queryList(
        'SELECT pl.*,st.* FROM Playlist pl INNER JOIN  PlaylistDetail dt on pl.id = dt.playlistId INNER JOIN Stream st ON st.uid = dt.streamId INNER JOIN StreamState sst ON st.uid = sst.streamId WHERE pl.id = ?1 ORDER BY dt.joinIndex ASC',
        mapper: (Map<String, Object?> row) => StreamStateEntity(row['streamId'] as String, row['progressTime'] as int),
        arguments: [playListId]);
  }

  @override
  Future<List<PlaylistDetailEntity>> getPlayListDetail(int playListId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM PlaylistDetail p WHERE p.playlistId = ?1',
        mapper: (Map<String, Object?> row) => PlaylistDetailEntity(
            playlistId: row['playlistId'] as int,
            streamId: row['streamId'] as int,
            joinIndex: row['joinIndex'] as int),
        arguments: [playListId]);
  }

  @override
  Future<void> deleteStreamFromPlayList(int playListId, int streamId) async {
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
            streamId: row['streamId'] as int,
            joinIndex: row['joinIndex'] as int));
  }

  @override
  Stream<List<PlaylistDetailEntity>> findAllAsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM PlaylistDetail',
        mapper: (Map<String, Object?> row) => PlaylistDetailEntity(
            playlistId: row['playlistId'] as int,
            streamId: row['streamId'] as int,
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

class _$SearchHistoryDao extends SearchHistoryDao {
  _$SearchHistoryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _searchHistoryEntityInsertionAdapter = InsertionAdapter(
            database,
            'SearchHistory',
            (SearchHistoryEntity item) => <String, Object?>{
                  'search': item.search,
                  'creationDate': item.creationDate
                }),
        _searchHistoryEntityUpdateAdapter = UpdateAdapter(
            database,
            'SearchHistory',
            ['search'],
            (SearchHistoryEntity item) => <String, Object?>{
                  'search': item.search,
                  'creationDate': item.creationDate
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SearchHistoryEntity>
      _searchHistoryEntityInsertionAdapter;

  final UpdateAdapter<SearchHistoryEntity> _searchHistoryEntityUpdateAdapter;

  @override
  Future<List<SearchHistoryEntity>> findAll() async {
    return _queryAdapter.queryList(
        'SELECT * FROM SearchHistory order by creationDate DESC',
        mapper: (Map<String, Object?> row) => SearchHistoryEntity(
            row['search'] as String, row['creationDate'] as int));
  }

  @override
  Future<void> clearSearchHistory() async {
    await _queryAdapter.queryNoReturn('DELETE FROM SearchHistory');
  }

  @override
  Future<void> deleteSearchHistory(String text) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM SearchHistory WHERE search = ?1',
        arguments: [text]);
  }

  @override
  Future<SearchHistoryEntity?> firstOrNull(String text) async {
    return _queryAdapter.query(
        'SELECT *  FROM SearchHistory WHERE search = ?1 LIMIT 1',
        mapper: (Map<String, Object?> row) => SearchHistoryEntity(
            row['search'] as String, row['creationDate'] as int),
        arguments: [text]);
  }

  @override
  Future<List<SearchHistoryEntity>> findSimilarText(
      String text, int limit) async {
    return _queryAdapter.queryList(
        'SELECT *  FROM SearchHistory WHERE search LIKE ?1 || \'%\' order by creationDate DESC LIMIT ?2',
        mapper: (Map<String, Object?> row) => SearchHistoryEntity(row['search'] as String, row['creationDate'] as int),
        arguments: [text, limit]);
  }

  @override
  Future<void> insertSearchHistory(SearchHistoryEntity entity) async {
    await _searchHistoryEntityInsertionAdapter.insert(
        entity, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateSearchHistory(SearchHistoryEntity entity) async {
    await _searchHistoryEntityUpdateAdapter.update(
        entity, OnConflictStrategy.abort);
  }
}
