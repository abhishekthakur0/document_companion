import 'package:document_companion/modules/home/view/homepage.dart';
import 'package:document_companion/modules/home/view/images_preview.dart';
import 'package:flutter/material.dart';

import '../modules/home/models/folder_view_model.dart';
import '../modules/home/view/folder_page.dart';
import '../modules/scan/view/scan.dart';

class RouteGenerator {
  static Route<MaterialPageRoute> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Homepage.route:
        return MaterialPageRoute(
          builder: (_) => Homepage(),
          settings: settings,
        );
      case Scan.route:
        return MaterialPageRoute(
          builder: (_) => Scan(),
          settings: settings,
        );
      case FolderPage.route:
        return MaterialPageRoute(
          builder: (_) => FolderPage(
            folder: settings.arguments as FolderViewModel,
          ),
          settings: settings,
        );
      case ImagesPreview.route:
        return MaterialPageRoute(
          builder: (_) => ImagesPreview(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const SizedBox(),
          settings: settings,
        );
    }
  }
}
