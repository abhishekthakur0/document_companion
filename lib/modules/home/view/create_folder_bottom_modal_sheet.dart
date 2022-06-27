import 'package:document_companion/config/custom_colors.dart';
import 'package:document_companion/modules/home/bloc/folder_bloc.dart';
import 'package:flutter/material.dart';

class CreateFolderBottomModalSheet extends StatelessWidget {
  const CreateFolderBottomModalSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String folderName = '';

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Create new folder',
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Folder name',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: CustomColors.leatherJacket,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: CustomColors.leatherJacket,
                      ),
                    ),
                    enabled: true,
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: CustomColors.leatherJacket,
                      ),
                    ),
                  ),
                  onChanged: (typedData) {
                    folderName = typedData;
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                backgroundColor: CustomColors.leatherJacket,
                child: IconButton(
                  onPressed: () {
                    folderBloc
                        .createFolder(folderName)
                        .then((value) => Navigator.pop(context));
                  },
                  icon: Icon(
                    Icons.done,
                    color: CustomColors.white,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
