import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom_colors.dart';

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = false;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: CustomColors.white,
      backgroundColor: CustomColors.leatherJacket,
      scaffoldBackgroundColor: CustomColors.leatherJacket,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: CustomColors.leatherJacket,
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: CustomColors.leatherJacket,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: CustomColors.portGore,
        hoverColor: CustomColors.portGore,
        focusColor: CustomColors.portGore,
      ),
      scrollbarTheme: const ScrollbarThemeData().copyWith(
        thumbColor: MaterialStateProperty.all(
          CustomColors.white,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: CustomColors.thunderbird,
        selectedItemColor: CustomColors.white,
        unselectedItemColor: CustomColors.white,
        elevation: 0,
        selectedLabelStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: CustomColors.white,
        ),
        showUnselectedLabels: false,
      ),
      fontFamily: 'Montserrat',
      textTheme: const TextTheme(
        headline1: TextStyle(
          fontSize: 22,
          color: CustomColors.black,
        ),
        headline2: TextStyle(
          fontSize: 20,
          color: CustomColors.black,
        ),
        headline3: TextStyle(
          fontSize: 19,
          color: CustomColors.black,
        ),
        headline4: TextStyle(
          fontSize: 18,
          color: CustomColors.black,
        ),
        headline5: TextStyle(
          fontSize: 17,
          color: CustomColors.black,
        ),
        headline6: TextStyle(
          fontSize: 16,
          color: CustomColors.black,
        ),
        bodyText1: TextStyle(
          fontSize: 15,
          color: CustomColors.black,
        ),
        bodyText2: TextStyle(
          fontSize: 14,
          color: CustomColors.black,
        ),
        subtitle1: TextStyle(
          fontSize: 12,
          color: CustomColors.black,
        ),
        subtitle2: TextStyle(
          fontSize: 10,
          color: CustomColors.black,
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: CustomColors.portGore,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(
            CustomColors.alto,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(
            CustomColors.thunderbird,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(
            CustomColors.thunderbird,
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: CustomColors.black,
      scaffoldBackgroundColor: CustomColors.black,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: CustomColors.pippin,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      fontFamily: 'Montserrat',
      textTheme: ThemeData.dark().textTheme,
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    );
  }
}
