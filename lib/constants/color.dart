import 'package:flutter/material.dart';

class PlatformColor {
  final HexColor primaryColor;
  final List<HexColor> gradientColor;

  const PlatformColor({
    required this.primaryColor,
    required this.gradientColor,
  });
}

// 转化web颜色到Color
class HexColor extends Color {
  static int getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(getColorFromHex(hexColor));
}

class ColorConstant {
  // 透明色
  static const Color transparentColor = Color.fromRGBO(0, 0, 0, 0);
  // 默认主题色
  static Color primaryColor = HexColor('#DDBD97');
  // 渐变色
  static List<HexColor> gradientColor = [
    HexColor('#D0A673'),
    HexColor('#EFD9BF')
  ];
  // 默认字体颜色
  static Color strongColor = HexColor('#414655'); // 强调色
  static Color normalColor = HexColor('#6C7BA8'); // 常规色
  static Color negativeColor = HexColor('#cbced8'); // 置灰色
  static Color positiveColor = HexColor('#6AAAF5'); // 激活色
  static Color warningColor = HexColor('#db6372'); // 警告色
  // 通用色
  static Color backgroundColor = HexColor('#F7F9FE'); // 背景色1
  static Color background2Color = HexColor('#F0F2F6'); // 背景色2
  static Color background3Color = HexColor('#ECEEF2'); // 背景色3
  static Color divideColor = HexColor('#EEEEEE'); // 分割线
  static Color whiteColor = HexColor('#FFFFFF'); // 白色
}
