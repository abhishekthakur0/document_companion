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
  String low_res_image;
  toMap() {
    return {
      'id': id,
      'image': Util(),
      'timestamp': timestamp,
      'is_shoot_through_fast_camera': is_shoot_through_fast_camera,
      'low_res_image': low_res_image,
    };
  }
}
