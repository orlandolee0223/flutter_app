import 'package:flutter/material.dart';
// constants
import 'package:flutter_app/constants/color.dart';
// components
import 'package:flutter_app/components/loading/index.dart';

class RefresherLoading extends StatelessWidget {
  const RefresherLoading({
    super.key,
    this.size = 16.0,
    this.text = '',
  });

  final double? size;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Loading(width: size!),
        text != ''
            ? Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  text!,
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorConstant.normalColor,
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
