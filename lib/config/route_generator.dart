import 'package:document_companion/modules/home/view/homepage.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<MaterialPageRoute> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Homepage.route:
        return MaterialPageRoute(
          builder: (_) => Homepage(),
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
