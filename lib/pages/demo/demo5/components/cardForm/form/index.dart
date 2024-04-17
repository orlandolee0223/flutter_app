import 'package:flutter/material.dart';
// flutter_animate
import 'package:flutter_animate/flutter_animate.dart';
// constants
import 'package:flutter_app/constants/color.dart';
import '../constants.dart';

class FormView extends StatefulWidget {
  const FormView({
    super.key,
    this.handleType,
  });

  final ValueChanged<bool>? handleType;

  @override
  FormViewState createState() => FormViewState();
}

class FormViewState extends State<FormView> {
  String title = '';

  bool isAnimate = false; // 动画

  void onItem() async {
    setState(() {
      title = '我点击了';
      isAnimate = true;
    });
    await Future.delayed(const Duration(milliseconds: animateDuration));
    if (widget.handleType is Function) {
      widget.handleType!(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Animate(
        effects: isAnimate
            ? <Effect>[
                ScaleEffect(
                  duration: animateDuration.ms,
                  begin: ScaleConfig.leaveBegin,
                  end: ScaleConfig.leaveEnd,
                ),
                FlipEffect(
                  duration: animateDuration.ms,
                  begin: FlipConfig.leaveBegin,
                  end: FlipConfig.leaveEnd,
                  perspective: FlipConfig.perspective,
                  alignment: FlipConfig.alignment,
                  direction: Axis.horizontal,
                ),
              ]
            : <Effect>[],
        child: Container(
          height: 300,
          color: ColorConstant.whiteColor,
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  title,
                  style: TextStyle(
                    color: ColorConstant.primaryColor,
                    fontSize: 18,
                  ),
                ),
              ),
              InkWell(
                onTap: onItem,
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ColorConstant.primaryColor,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '点击',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
