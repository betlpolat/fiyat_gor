import 'package:flutter/material.dart';

class Constants{
  static double defaultPadding = 8.0;
  static double defaultBorderRadius = 8.0;
  static const Color mainColor = Color(0xFFFB8C00);
  static const Color lightColor = Color(0xFFF5F5F7);
  static const Color backColor = Color(0xFFE8EAF6);
  static const Color secondaryColor = Color(0xFF6c757d);
  static const Color darkGreyColor = Color(0xff4A4D52);
  static const Color greenColor =Color(0xFF09BB14);
  static  Color blackColor = Colors.black.withOpacity(.5);
  static const Color whiteColor = Colors.white;
  static const Color greyColor = Colors.grey;
  static const String cartTitle="Sepetim";
  static const String appTitle="Fiyat Gör";
  static const String searchBarcodeText="Barkod Ara";

  Widget customCircularProggressIndicator = const Center(
      child: CircularProgressIndicator(
        color: Constants.mainColor,
      ));

}