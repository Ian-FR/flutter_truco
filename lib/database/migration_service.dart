import 'dart:math';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'migration.dart';

const databaseName = 'test.db';

class MigrationService {

  final List<Migration> _migrations = [];

  get _nextVersion => this._migrations.asMap().keys.reduce(max) + 1;

  void createTable({required String name, required String script}) {
    this._migrations.add(
          Migration(type: MigrationType.createTable, table: name, script: script, commands: []),
        );
  }

  void addColumn({required String name, required String table, required String script}) {
    this._migrations.add(
          Migration(
            type: MigrationType.addColumn,
            table: table,
            column: name,
            script: script,
          ),
        );
  }

  void runCommands({required List<String> commands}) {
    this._migrations.add(
          Migration(
            type: MigrationType.runCommands,
            commands: commands,
          ),
        );
  }

  Future<int> _getVersion(Database db) async {
    final resultQuery = await db.rawQuery('PRAGMA user_version;');
    final version = resultQuery.first['user_version'].toString();
    return int.parse(version) - 1;
  }

  Future<void> _upgradeVersion(Database db, int version) async {
    await db.rawQuery("PRAGMA user_version = $version;");
  }

  Future<void> _runMigration(Database db, Migration migration) async {
    migration.log();
    if (migration.type == MigrationType.runCommands) {
      migration.commands.asMap().entries.forEach(
        (e) async {
          print('- script ${e.key + 1} of ${migration.commands.length}:');
          print(e.value);
          await db.execute(e.value);
        },
      );
    } else {
      print(migration.script);
      await db.execute(migration.script);
    }
  }

  Future<Database> initDB() async {
    final path = join(await getDatabasesPath(), databaseName);

    final onCreate = (Database db, int _) => this._migrations.forEach((m) => _runMigration(db, m));

    final onUpgrade = (Database db, int _, int __) async {
      final currentVersion = await _getVersion(db);

      final _migrations = this
          ._migrations
          .asMap()
          .entries
          .where(
            (e) => e.key > currentVersion,
          )
          .map((e) => e.value);

      if (_migrations.length == 0) return;

      _migrations.forEach((m) => _runMigration(db, m));

      _upgradeVersion(db, _nextVersion);
    };

    return await openDatabase(
      path,
      version: _nextVersion,
      onCreate: onCreate,
      onUpgrade: onUpgrade,
    );
  }
}
