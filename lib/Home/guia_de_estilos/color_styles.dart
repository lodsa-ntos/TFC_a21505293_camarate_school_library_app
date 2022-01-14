import 'package:flutter/material.dart';

// lista de cores
const Color primaryColor = Color(0xFFDB3620);
const Color primaryColorOpacity = Color(0xFFFF7F50);
const Color hintTextColor = Color(0xFFE4E0E8);
const Color primaryTextColor = Color(0xFF1A1316);
const Color secondaryTextColor = Color(0xFF8391A0);
const Color tertiaryTextColor = Color(0xFFB5ADAC);
final Color greenColor = Colors.green.shade400;
const Color blueColor = Colors.lightBlueAccent;
const kBackgroundColor = Color(0xFFF1EFF1);
const kPrimaryColor = Color(0xFF035AA6);
const kSecondaryColor = Color(0xFFFFA41B);
const kTextColor = Color(0xFF000839);
const kTextLightColor = Color(0xFF747474);
const kBlueColor = Color(0xFF40BAD5);
const Color darkColor = Color(0xff2D2D2D);

class MyThemeColor {
  static Color darkBluishColor = const Color(0xff403b58);
  static Color myBlueStyleColor = const Color(0x003b5998);
  static Color myGreyStyleColor = const Color(0xFF616161);
}

class CustomColors {
  static Color activePrimaryButton = const Color.fromARGB(255, 63, 81, 181);
  static Color activeSecondaryButton = const Color.fromARGB(255, 230, 230, 255);
  static Color gradientMainColor = const Color(0xff00ADFA);
  static Color gradientSecColor = const Color(0xff00E6FD);
  static Color appBarMainColor = const Color(0xff0A6D92);

  Color getActivePrimaryButtonColor() {
    return activePrimaryButton;
  }

  Color getActiveSecondaryButton() {
    return activeSecondaryButton;
  }

  Color getGradientMainColor() {
    return gradientMainColor;
  }

  Color getGradientSecondaryColor() {
    return gradientSecColor;
  }

  Color getAppBarMainColor() {
    return appBarMainColor;
  }
}
