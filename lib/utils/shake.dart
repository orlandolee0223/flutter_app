import 'package:flutter/services.dart';

// 震动反馈
Future<void> handleShake() async {
  HapticFeedback.heavyImpact(); // 震动反馈
}
