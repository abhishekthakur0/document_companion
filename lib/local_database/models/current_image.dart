class CurrentImage {
  CurrentImage({
    required this.id,
    required this.image,
    required this.timestamp,
    required this.is_shoot_through_fast_camera,
    required this.low_res_image,
  });
  String id;
  String image;
  String timestamp;
  bool is_shoot_through_fast_camera;
  String low_res_image;
  toMap() {}
}
