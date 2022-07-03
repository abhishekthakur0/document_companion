import 'dart:async';

import 'package:document_companion/local_database/handler/folder_table_handler.dart';
import 'package:document_companion/local_database/models/folder_model.dart';
import 'package:uuid/uuid.dart';

import '../models/folder_view_model.dart';

class FolderBloc {
  final uuid = Uuid();
  StreamController<List<FolderViewModel>> folderListController =
      StreamController<List<FolderViewModel>>.broadcast();
  Stream<List<FolderViewModel>> get folderList => folderListController.stream;

  Future<void> createFolder(String folderName) async {
    final tableData = FolderModel(
      id: uuid.v4(),
      folder_name: folderName,
      created_on: DateTime.now().millisecondsSinceEpoch.toString(),
      modified_on: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    await folderTableHandler.insertFolder(tableData);
    folderBloc.fetchFolders();
  }

  Future<void> fetchFolders() async {
    List<FolderModel> foldersData = await folderTableHandler.getFolders();
    List<FolderViewModel> folderViewData = [];
    foldersData.forEach(
      (folder) => folderViewData.add(
        FolderViewModel(
          id: folder.id,
          created_on: folder.created_on,
          folder_name: folder.folder_name,
          modified_on: folder.modified_on,
        ),
      ),
    );
    folderListController.add(folderViewData);
  }
}

final folderBloc = FolderBloc();
