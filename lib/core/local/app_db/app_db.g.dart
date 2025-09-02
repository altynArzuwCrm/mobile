// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDataBaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDataBaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDataBaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDataBase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDataBase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDataBaseBuilderContract databaseBuilder(String name) =>
      _$AppDataBaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDataBaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDataBaseBuilder(null);
}

class _$AppDataBaseBuilder implements $AppDataBaseBuilderContract {
  _$AppDataBaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDataBaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDataBaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDataBase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDataBase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDataBase extends AppDataBase {
  _$AppDataBase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  OrderDao? _orderDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
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
            'CREATE TABLE IF NOT EXISTS `OrderLocalEntity` (`id` INTEGER NOT NULL, `clientId` INTEGER, `projectId` INTEGER, `productId` INTEGER, `stageId` INTEGER, `quantity` INTEGER, `deadline` TEXT NOT NULL, `price` TEXT, `reason` TEXT, `reasonStatus` TEXT, `archivedAt` TEXT, `isArchived` INTEGER, `createdAt` TEXT NOT NULL, `updatedAt` TEXT NOT NULL, `project` TEXT, `product` TEXT, `client` TEXT, `stage` TEXT, `currentStage` TEXT, `assignments` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  OrderDao get orderDao {
    return _orderDaoInstance ??= _$OrderDao(database, changeListener);
  }
}

class _$OrderDao extends OrderDao {
  _$OrderDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _orderLocalEntityInsertionAdapter = InsertionAdapter(
            database,
            'OrderLocalEntity',
            (OrderLocalEntity item) => <String, Object?>{
                  'id': item.id,
                  'clientId': item.clientId,
                  'projectId': item.projectId,
                  'productId': item.productId,
                  'stageId': item.stageId,
                  'quantity': item.quantity,
                  'deadline': item.deadline,
                  'price': item.price,
                  'reason': item.reason,
                  'reasonStatus': item.reasonStatus,
                  'archivedAt': item.archivedAt,
                  'isArchived': item.isArchived == null
                      ? null
                      : (item.isArchived! ? 1 : 0),
                  'createdAt': item.createdAt,
                  'updatedAt': _dateTimeConverter.encode(item.updatedAt),
                  'project': _projectConverter.encode(item.project),
                  'product': _productConverter.encode(item.product),
                  'client': _clientConverter.encode(item.client),
                  'stage': _stageConverter.encode(item.stage),
                  'currentStage': _stageConverter.encode(item.currentStage),
                  'assignments':
                      _assignmentListConverter.encode(item.assignments)
                }),
        _orderLocalEntityUpdateAdapter = UpdateAdapter(
            database,
            'OrderLocalEntity',
            ['id'],
            (OrderLocalEntity item) => <String, Object?>{
                  'id': item.id,
                  'clientId': item.clientId,
                  'projectId': item.projectId,
                  'productId': item.productId,
                  'stageId': item.stageId,
                  'quantity': item.quantity,
                  'deadline': item.deadline,
                  'price': item.price,
                  'reason': item.reason,
                  'reasonStatus': item.reasonStatus,
                  'archivedAt': item.archivedAt,
                  'isArchived': item.isArchived == null
                      ? null
                      : (item.isArchived! ? 1 : 0),
                  'createdAt': item.createdAt,
                  'updatedAt': _dateTimeConverter.encode(item.updatedAt),
                  'project': _projectConverter.encode(item.project),
                  'product': _productConverter.encode(item.product),
                  'client': _clientConverter.encode(item.client),
                  'stage': _stageConverter.encode(item.stage),
                  'currentStage': _stageConverter.encode(item.currentStage),
                  'assignments':
                      _assignmentListConverter.encode(item.assignments)
                }),
        _orderLocalEntityDeletionAdapter = DeletionAdapter(
            database,
            'OrderLocalEntity',
            ['id'],
            (OrderLocalEntity item) => <String, Object?>{
                  'id': item.id,
                  'clientId': item.clientId,
                  'projectId': item.projectId,
                  'productId': item.productId,
                  'stageId': item.stageId,
                  'quantity': item.quantity,
                  'deadline': item.deadline,
                  'price': item.price,
                  'reason': item.reason,
                  'reasonStatus': item.reasonStatus,
                  'archivedAt': item.archivedAt,
                  'isArchived': item.isArchived == null
                      ? null
                      : (item.isArchived! ? 1 : 0),
                  'createdAt': item.createdAt,
                  'updatedAt': _dateTimeConverter.encode(item.updatedAt),
                  'project': _projectConverter.encode(item.project),
                  'product': _productConverter.encode(item.product),
                  'client': _clientConverter.encode(item.client),
                  'stage': _stageConverter.encode(item.stage),
                  'currentStage': _stageConverter.encode(item.currentStage),
                  'assignments':
                      _assignmentListConverter.encode(item.assignments)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<OrderLocalEntity> _orderLocalEntityInsertionAdapter;

  final UpdateAdapter<OrderLocalEntity> _orderLocalEntityUpdateAdapter;

  final DeletionAdapter<OrderLocalEntity> _orderLocalEntityDeletionAdapter;

  @override
  Future<List<OrderLocalEntity>> getAllOrders() async {
    return _queryAdapter.queryList(
        'SELECT * FROM OrderLocalEntity ORDER BY updatedAt DESC',
        mapper: (Map<String, Object?> row) => OrderLocalEntity(
            id: row['id'] as int,
            clientId: row['clientId'] as int?,
            projectId: row['projectId'] as int?,
            productId: row['productId'] as int?,
            stageId: row['stageId'] as int?,
            quantity: row['quantity'] as int?,
            deadline: row['deadline'] as String,
            price: row['price'] as String?,
            reason: row['reason'] as String?,
            reasonStatus: row['reasonStatus'] as String?,
            archivedAt: row['archivedAt'] as String?,
            isArchived: row['isArchived'] == null
                ? null
                : (row['isArchived'] as int) != 0,
            createdAt: row['createdAt'] as String,
            updatedAt: _dateTimeConverter.decode(row['updatedAt'] as String),
            project: _projectConverter.decode(row['project'] as String?),
            product: _productConverter.decode(row['product'] as String?),
            client: _clientConverter.decode(row['client'] as String?),
            stage: _stageConverter.decode(row['stage'] as String?),
            currentStage:
                _stageConverter.decode(row['currentStage'] as String?),
            assignments:
                _assignmentListConverter.decode(row['assignments'] as String)));
  }

  @override
  Future<OrderLocalEntity?> getOrderById(int id) async {
    return _queryAdapter.query('SELECT * FROM OrderLocalEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => OrderLocalEntity(
            id: row['id'] as int,
            clientId: row['clientId'] as int?,
            projectId: row['projectId'] as int?,
            productId: row['productId'] as int?,
            stageId: row['stageId'] as int?,
            quantity: row['quantity'] as int?,
            deadline: row['deadline'] as String,
            price: row['price'] as String?,
            reason: row['reason'] as String?,
            reasonStatus: row['reasonStatus'] as String?,
            archivedAt: row['archivedAt'] as String?,
            isArchived: row['isArchived'] == null
                ? null
                : (row['isArchived'] as int) != 0,
            createdAt: row['createdAt'] as String,
            updatedAt: _dateTimeConverter.decode(row['updatedAt'] as String),
            project: _projectConverter.decode(row['project'] as String?),
            product: _productConverter.decode(row['product'] as String?),
            client: _clientConverter.decode(row['client'] as String?),
            stage: _stageConverter.decode(row['stage'] as String?),
            currentStage:
                _stageConverter.decode(row['currentStage'] as String?),
            assignments:
                _assignmentListConverter.decode(row['assignments'] as String)),
        arguments: [id]);
  }

  @override
  Future<void> clearOrders() async {
    await _queryAdapter.queryNoReturn('DELETE FROM OrderLocalEntity');
  }

  @override
  Future<void> insertOrder(OrderLocalEntity order) async {
    await _orderLocalEntityInsertionAdapter.insert(
        order, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertOrders(List<OrderLocalEntity> orders) async {
    await _orderLocalEntityInsertionAdapter.insertList(
        orders, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateOrder(OrderLocalEntity order) async {
    await _orderLocalEntityUpdateAdapter.update(
        order, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteOrder(OrderLocalEntity order) async {
    await _orderLocalEntityDeletionAdapter.delete(order);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
final _projectConverter = ProjectConverter();
final _productConverter = ProductConverter();
final _clientConverter = ClientConverter();
final _stageConverter = StageConverter();
final _assignmentListConverter = AssignmentListConverter();
