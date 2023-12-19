import 'package:flutter/material.dart';

// flutter 默认返回偏移量
// flutter/packages/flutter/lib/src/cupertino/route.dart 59行
final Animatable<Offset> packetMiddleLeftTween = Tween<Offset>(
  begin: Offset.zero,
  end: const Offset(-1.0 / 3.0, 0.0),
);
