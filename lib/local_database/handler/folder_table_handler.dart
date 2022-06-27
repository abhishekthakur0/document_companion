import 'package:document_companion/local_database/handler/local_database_handler.dart';

import '../models/folder_model.dart';

class FolderTableHandler {
  static const _tableName = 'Folders';
  /*
  Table Name - Folders
  Columns - id | folder_name | created_on | modified_on
   */

  Future<void> insertFolder(FolderModel tableData) async {
    final _database = await localDatabaseHandler.db;
    _database?.insert(
      _tableName,
      tableData.toMap(),
    );
  }

  Future<List<FolderModel>> getFolders() async {
    final _database = await localDatabaseHandler.db;
    final maps = await _database?.query(_tableName);
    return List.generate(maps?.length ?? 0, (i) {
      final map = maps?.elementAt(i);
      final id = map!['id'].toString();
      final created_on = map['created_on'].toString();
      final folder_name = map['folder_name'].toString();
      final modified_on = map['modified_on'].toString();
      return FolderModel(
        id: id,
        created_on: created_on,
        folder_name: folder_name,
        modified_on: modified_on,
      );
    });
  }
}

final folderTableHandler = FolderTableHandler();
