import 'package:flutter/material.dart';
// flutter_screenutil
import 'package:flutter_screenutil/flutter_screenutil.dart';
// constants
import 'package:flutter_app/constants/color.dart';
// components
import 'package:flutter_app/components/header/index.dart';

class Demo2Page extends StatefulWidget {
  const Demo2Page({super.key});

  @override
  Demo2PageState createState() => Demo2PageState();
}

class Demo2PageState extends State<Demo2Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: Header(
        title: 'Demo2',
        color: ColorConstant.strongColor,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 1000.w,
          child: const Text('Demo2'),
        ),
      ),
    );
  }
}
