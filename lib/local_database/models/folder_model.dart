class FolderModel {
  FolderModel({
    required this.id,
    required this.folder_name,
    required this.created_on,
    required this.modified_on,
  });
  String id;
  String folder_name;
  String created_on;
  String modified_on;
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'folder_name': folder_name,
      'created_on': created_on,
      'modified_on': modified_on,
    };
  }
}
