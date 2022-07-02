import 'package:flutter/material.dart';

import '../models/folder_view_model.dart';

class FolderPage extends StatefulWidget {
  static const route = '/folder/folder_page';
  const FolderPage({Key? key, required this.folder}) : super(key: key);

  final FolderViewModel folder;
  @override
  State<FolderPage> createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.folder.folder_name),
      ),
      body: Center(
        child: Text(widget.folder.folder_name),
      ),
    );
  }
}
