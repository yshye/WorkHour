import 'package:flutter/material.dart';

class Hues {
  static const Color appMain = Color(0xFF487cff);
  static const Color darkAppMain = Color(0xFF3F7AE0);

  static const Color bgColor = Color(0xFFEAEDF3);
  static const Color darkzBgColor = Colors.grey;

  static const Color barColor = Color(0xfff1f1f1);
  static const Color darkBarColor = Colors.black;

  static const Color materialBg = Color(0xFFFFFFFF);
  static const Color darkMaterialBg = Color(0xFF303233);

  static const Color text = Color(0xFF333333);
  static const Color darkText = Color(0xFFB8B8B8);

  static const Color textTitle = Color(0xFF5d6478);
  static const Color darkTextTitle = Color(0xFFB8B8B8);

  static const Color textGray = Color(0xFF999999);
  static const Color darkTextaGray = Color(0xFF666666);

  static const Color textGrayC = Color(0xFFcccccc);
  static const Color darkButtonText = Color(0xFFF2F2F2);

  static const Color bgGray = Color(0xFFF6F6F6);
  static const Color darkBgGray = Color(0xFF1F1F1F);

  static const Color line = Color(0xFFCBD0D9);
  static const Color darkLine = Color(0xFF3A3C3D);

  static const Color red = Color(0xFFFF4759);
  static const Color darkRed = Color(0xFFE03E4E);

  static const Color textDisabled = Color(0xFFD4E2FA);
  static const Color darkTextDisabled = Color(0xFFCEDBF2);

  static const Color buttonDisabled = Color(0xFF96BBFA);
  static const Color darkButtonDisabled = Color(0xFF83A5E0);

  static const Color unselectedItemColor = Color(0xffbfbfbf);
  static const Color darkUnselectedItemColor = Color(0xFF4D4D4D);

  static const Color bgGray2 = Color(0xFFFAFAFA);
  static const Color darkBgGray2 = Color(0xFF242526);

  static const Color error = Colors.red;

  static const Color danger = Color(0xFFF56C6C);
  static const Color warning = Color(0xFFE6A23C);
  static const Color success = Color(0xFF67C23A);
  static const Color info = Color(0xFF909399);
  static const Color primary = Color(0xFF409EFF);
  static const Color primaryText = Color(0xFF303133);
  static const Color regularText = Color(0xFF606266);
  static const Color secondaryText = Color(0xFF909399);
  static const Color placeholder = Color(0xFFC0C4CC);
  static const Color borderBase = Color(0xFFDCDFE6);
  static const Color borderLight = Color(0xFFE4E7ED);
  static const Color borderLighter = Color(0xFFEBEEF5);
  static const Color borderExtralight = Color(0xFFF2F6FC);

  static final ColorTheme unStart = ColorTheme(const Color(0xfff2f7ff),
      const Color(0xff5a87cb), const Color(0xff5a87cb));
  static final ColorTheme audit = ColorTheme(const Color(0xfff5e9ff),
      const Color(0xffa16ad1), const Color(0xffa16ad1));
  static final ColorTheme doing = ColorTheme(const Color(0xffe8fff6),
      const Color(0xff38c38a), const Color(0xff38c38a));
  static final ColorTheme stop = ColorTheme(const Color(0xffeaeaea),
      const Color(0xff9d9d9d), const Color(0xff9d9d9d));
}

class ColorTheme {
  Color backgroundColor;
  Color color;
  Color borderColor;

  ColorTheme(this.backgroundColor, this.color, this.borderColor);
}
