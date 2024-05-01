import 'package:flutter/material.dart';
// flutter_animate
import 'package:flutter_animate/flutter_animate.dart';
// config
import 'package:flutter_app/config/image.dart';
// components
import 'package:flutter_app/components/image/index.dart';

class Loading extends StatelessWidget {
  const Loading({
    super.key,
    this.src,
    this.width = 20.0,
  });

  final String? src;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return MyImage(
      src: src ?? 'loading.png'.images,
      width: width,
    ).animate(
      onPlay: (controller) {
        controller.repeat(); // loop
      },
    ).rotate(duration: 800.ms);
  }
}
