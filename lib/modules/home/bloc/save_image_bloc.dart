import 'package:document_companion/config/custom_key.dart';
import 'package:flutter/material.dart';

import '../view/save_image_bottom_sheet.dart';

class SaveImageBloc {
  void openSaveImageSheet() {
    showModalBottomSheet(
      context: CustomKey.navigatorKey.currentContext!,
      builder: (context) => SaveImageBottomSheet(),
    );
  }
}

final saveImageBloc = SaveImageBloc();
