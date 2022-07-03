import 'dart:typed_data';

import 'package:document_companion/local_database/handler/local_database_handler.dart';

import '../models/current_image.dart';

class CurrentImageDatabaseHandler {
  static const _tableName = 'CurrentImages';
  void insertImage(CurrentImage currentImage) async {
    final _database = await localDatabaseHandler.db;
    _database?.insert(
      _tableName,
      currentImage.toMap(),
    );
  }

  Future<List<CurrentImage>> getCurrentImage() async {
    final _database = await localDatabaseHandler.db;
    final List<Map<String, Object?>>? maps = await _database?.query(_tableName);
    return List.generate(maps?.length ?? 0, (i) {
      final map = maps?.elementAt(i);
      return CurrentImage(
        id: map!['id'] as String,
        image: map['image'] as Uint8List,
        timestamp: map['timestamp'] as String,
        is_shoot_through_fast_camera:
            bool.fromEnvironment(map['is_shoot_through_fast_camera'] as String),
        low_res_image: map['low_res_image'] as Uint8List,
      );
    });
  }

  Future<void> deleteCurrentImage() async {
    final _database = await localDatabaseHandler.db;
    _database?.delete(
      _tableName,
    );
  }
}
