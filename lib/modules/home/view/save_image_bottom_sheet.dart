import 'package:document_companion/modules/home/bloc/folder_bloc.dart';
import 'package:flutter/material.dart';

import '../../../config/custom_colors.dart';
import '../models/folder_selection_model.dart';

class SaveImageBottomSheet extends StatefulWidget {
  const SaveImageBottomSheet({Key? key}) : super(key: key);

  @override
  State<SaveImageBottomSheet> createState() => _SaveImageBottomSheetState();
}

class _SaveImageBottomSheetState extends State<SaveImageBottomSheet> {
  final folderList = [];

  @override
  void initState() {
    super.initState();
    folderBloc.fetchFolders();
    folderBloc.folderList.listen((event) {
      event.forEach((element) {
        folderList.add(
          FolderSelectionModel(element, false),
        );
      });
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: CustomColors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Save image to ',
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: folderList.length,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final folder = folderList.elementAt(index).folder;
                return ListTile(
                  leading: Checkbox(
                    activeColor: CustomColors.leatherJacket,
                    value: folderList.elementAt(index).isSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        folderList.elementAt(index).isSelected = value;
                      });
                    },
                  ),
                  title: Row(
                    children: [
                      Icon(
                        Icons.folder,
                        color: CustomColors.black,
                        size: 60,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            folder?.folder_name ?? '',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            folder?.created_on ?? '',
                            style: TextStyle(
                              fontSize: 12,
                              color: CustomColors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      folderList.elementAt(index).isSelected =
                          !folderList.elementAt(index).isSelected;
                    });
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton.icon(
            style: TextButton.styleFrom(
              primary: CustomColors.white,
              backgroundColor: CustomColors.leatherJacket,
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            icon: Icon(Icons.save),
            label: Text(
              'Save',
            ),
          ),
        ],
      ),
    );
  }
}
