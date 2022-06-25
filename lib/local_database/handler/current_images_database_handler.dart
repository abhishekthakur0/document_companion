import 'package:document_companion/local_database/handler/local_database_handler.dart';

import '../models/current_image.dart';

class CurrentImageDatabaseHandler {
  static const _tableName = 'CurrentImages';
  void insertImage(CurrentImage currentImage) async {
    final _database = await localDatabaseHandler.db;
    _database.insert(
      _tableName,
      currentImage.toMap(),
    );
  }
}
