enum MigrationType { createTable, addColumn, runCommands }

class Migration {
  final MigrationType type;
  final String table;
  final String column;
  final String script;
  final List<String> commands;

  Migration({
    required this.type,
    this.table = '',
    this.column = '',
    this.script = '',
    this.commands = const [],
  });

  void log() {
    final logs = {
      MigrationType.createTable: () => print('Creating table $table'),
      MigrationType.addColumn: () => print('Adding column $column on table $table'),
      MigrationType.runCommands: () => print('Running ${commands.length} commands'),
    };

    logs[this.type]!();
  }
}
