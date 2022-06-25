import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/custom_colors.dart';
import '../../bloc/app/app_state.dart';
import '../../document_scanner_controller.dart';
import '../../utils/edit_photo_document_style.dart';

class AppBarEditPhoto extends StatelessWidget {
  final EditPhotoDocumentStyle editPhotoDocumentStyle;

  const AppBarEditPhoto({
    Key? key,
    required this.editPhotoDocumentStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (editPhotoDocumentStyle.hideAppBarDefault) return Container();

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        margin: EdgeInsets.only(top: 50),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: CustomColors.black.withOpacity(0.4),
              child: IconButton(
                onPressed: () =>
                    context.read<DocumentScannerController>().changePage(
                          AppPages.cropPhoto,
                        ),
                icon: const Icon(
                  Icons.close,
                ),
                color: Colors.white,
              ),
            ),

            // * Crop photo
            Container(
              decoration: BoxDecoration(
                color: CustomColors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton.icon(
                onPressed: () => context
                    .read<DocumentScannerController>()
                    .savePhotoDocument(),
                label: Text(
                  editPhotoDocumentStyle.textButtonSave,
                ),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                ),
                icon: Icon(
                  Icons.save,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
