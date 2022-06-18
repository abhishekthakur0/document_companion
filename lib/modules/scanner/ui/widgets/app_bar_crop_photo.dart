import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/app/app_state.dart';
import '../../document_scanner_controller.dart';
import '../../utils/crop_photo_document_style.dart';

class AppBarCropPhoto extends StatelessWidget {
  final CropPhotoDocumentStyle cropPhotoDocumentStyle;

  const AppBarCropPhoto({
    Key? key,
    required this.cropPhotoDocumentStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cropPhotoDocumentStyle.hideAppBarDefault) return Container();

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () =>
                  context.read<DocumentScannerController>().changePage(
                        AppPages.takePhoto,
                      ),
              icon: const Icon(
                Icons.close,
              ),
              color: Colors.white,
            ),

            // * Crop photo
            TextButton(
              onPressed: () =>
                  context.read<DocumentScannerController>().cropPhoto(),
              child: Text(
                cropPhotoDocumentStyle.textButtonSave,
              ),
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
