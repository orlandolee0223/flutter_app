import 'package:flutter/cupertino.dart';

// 动画时长
const int animateDuration = 300;

// 缩放
class ScaleConfig {
  // 离开
  static Offset leaveBegin = const Offset(1, 1);
  static Offset leaveEnd = const Offset(0.7, 0.7);
  // 进入
  static Offset enterBegin = const Offset(0.7, 0.7);
  static Offset enterEnd = const Offset(1, 1);
}

// 缩放
class FlipConfig {
  static double perspective = 0.3;
  static Alignment alignment = Alignment.topCenter;
  // 离开
  static double leaveBegin = 0;
  static double leaveEnd = -0.5;
  // 进入
  static double enterBegin = 0.5;
  static double enterEnd = 0;
}
