import 'package:flutter/material.dart';
// constants
import 'package:flutter_app/constants/color.dart';
// components
import './cardForm/index.dart';

class DemoModal {
  static Future showCardForm(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withOpacity(0.7), // 遮罩颜色
      backgroundColor: ColorConstant.transparentColor, // 容器背景色
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const CardForm();
      },
    );
  }
}
