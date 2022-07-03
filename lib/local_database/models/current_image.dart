import 'dart:typed_data';

class CurrentImage {
  CurrentImage({
    required this.id,
    required this.image,
    required this.timestamp,
    required this.is_shoot_through_fast_camera,
    required this.low_res_image,
  });
  String id;
  Uint8List image;
  String timestamp;
  bool is_shoot_through_fast_camera;
  Uint8List low_res_image;
  toMap() {
    return {
      'id': id,
      'image': image,
      'timestamp': timestamp,
      'is_shoot_through_fast_camera': is_shoot_through_fast_camera.toString(),
      'low_res_image': low_res_image,
    };
  }
}
