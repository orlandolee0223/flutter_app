import 'package:flutter/material.dart';
// flutter_animate
import 'package:flutter_animate/flutter_animate.dart';
// constants
import 'package:flutter_app/constants/color.dart';
import '../constants.dart';

class ResultView extends StatefulWidget {
  const ResultView({super.key});

  @override
  ResultViewState createState() => ResultViewState();
}

class ResultViewState extends State<ResultView> {
  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: <Effect>[
        ScaleEffect(
          duration: animateDuration.ms,
          begin: ScaleConfig.enterBegin,
          end: ScaleConfig.enterEnd,
        ),
        FlipEffect(
          duration: animateDuration.ms,
          begin: FlipConfig.enterBegin,
          end: FlipConfig.enterEnd,
          perspective: FlipConfig.perspective,
          alignment: FlipConfig.alignment,
          direction: Axis.horizontal,
        ),
      ],
      child: Container(
        height: 200,
        color: ColorConstant.warningColor.withOpacity(0.3),
        child: Column(
          children: <Widget>[
            Container(
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: ColorConstant.primaryColor,
              ),
              alignment: Alignment.center,
              child: const Text(
                '内容',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
