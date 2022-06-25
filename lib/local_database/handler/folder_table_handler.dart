import 'package:document_companion/local_database/handler/local_database_handler.dart';

import '../models/table_model.dart';

class FolderTableHandler {
  static const _tableName = 'Folders';
  /*
  Table Name - Folders
  Columns - id | folder_name | created_on | modified_on
   */

  void insertFolder(TableModel tableData) async {
    final _database = await localDatabaseHandler.db;
    _database.insert(
      _tableName,
      tableData.toMap(),
    );
  }
}

final folderTableHandler = FolderTableHandler();
