import 'package:document_companion/config/custom_colors.dart';
import 'package:document_companion/modules/scan/view/scan.dart';
import 'package:flutter/material.dart';

import 'create_folder_bottom_modal_sheet.dart';

class CreateBottomModalSheet extends StatelessWidget {
  const CreateBottomModalSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Create new',
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(
            height: 20,
          ),
          Wrap(
            spacing: 80,
            runSpacing: 20,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                    ),
                    builder: (context) => Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: CreateFolderBottomModalSheet(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          25,
                        ),
                        border: Border.all(
                          color: CustomColors.leatherJacket,
                        ),
                      ),
                      child: Icon(
                        Icons.folder_outlined,
                        color: CustomColors.leatherJacket,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Folder',
                      style: Theme.of(context).textTheme.headline6,
                    )
                  ],
                ),
              ),
              InkWell(
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          25,
                        ),
                        border: Border.all(
                          color: CustomColors.leatherJacket,
                        ),
                      ),
                      child: Icon(
                        Icons.file_upload_outlined,
                        color: CustomColors.leatherJacket,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Add file',
                      style: Theme.of(context).textTheme.headline6,
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Scan.route);
                },
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          25,
                        ),
                        border: Border.all(
                          color: CustomColors.leatherJacket,
                        ),
                      ),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: CustomColors.leatherJacket,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Scan',
                      style: Theme.of(context).textTheme.headline6,
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
