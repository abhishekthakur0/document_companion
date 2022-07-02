import 'dart:typed_data';

import 'package:uuid/uuid.dart';

import '../../../local_database/handler/current_images_database_handler.dart';
import '../../../local_database/models/current_image.dart';

class CurrentImageBloc {
  CurrentImageDatabaseHandler _databaseHandler = CurrentImageDatabaseHandler();
  Uuid _uuid = Uuid();
  void saveCurrentImage(Uint8List currentImage) {
    try {
      _databaseHandler.insertImage(
        CurrentImage(
          image: currentImage,
          timestamp: DateTime.now().toUtc().millisecondsSinceEpoch.toString(),
          is_shoot_through_fast_camera: false,
          low_res_image: '',
          id: _uuid.v4(),
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}

final currentImageBloc = CurrentImageBloc();
