class TableModel {
  TableModel({
    required this.id,
    required this.folder_name,
    required this.created_on,
    required this.modified_on,
  });
  String id;
  String folder_name;
  String created_on;
  String modified_on;
  toMap() {}
}
