import 'dart:async';
import 'dart:typed_data';

import 'package:uuid/uuid.dart';

import '../../../local_database/handler/current_images_database_handler.dart';
import '../../../local_database/models/current_image.dart';

class CurrentImageBloc {
  StreamController<List<CurrentImage>> _currentImageController =
      StreamController<List<CurrentImage>>.broadcast();
  Stream<List<CurrentImage>> get currentImageStream =>
      _currentImageController.stream;

  CurrentImageDatabaseHandler _databaseHandler = CurrentImageDatabaseHandler();
  Uuid _uuid = Uuid();
  Future<void> saveCurrentImage(Uint8List currentImage) async {
    try {
      _databaseHandler.insertImage(
        CurrentImage(
          image: currentImage,
          timestamp: DateTime.now().toUtc().millisecondsSinceEpoch.toString(),
          is_shoot_through_fast_camera: false,
          low_res_image: currentImage,
          id: _uuid.v4(),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> getCurrentImage() async {
    try {
      final currentImage = await _databaseHandler.getCurrentImage();
      _currentImageController.sink.add(currentImage);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> deleteCurrentImages() async {
    try {
      _databaseHandler.deleteCurrentImage();
    } catch (e) {
      print(e);
    }
  }
}

final currentImageBloc = CurrentImageBloc();
