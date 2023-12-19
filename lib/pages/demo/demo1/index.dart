import 'package:flutter/material.dart';
// flutter_screenutil
import 'package:flutter_screenutil/flutter_screenutil.dart';
// constants
import 'package:flutter_app/constants/color.dart';
// components
import 'package:flutter_app/components/header/index.dart';

class Demo1Page extends StatefulWidget {
  const Demo1Page({super.key});

  @override
  Demo1PageState createState() => Demo1PageState();
}

class Demo1PageState extends State<Demo1Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: Header(
        title: 'Demo1',
        color: ColorConstant.strongColor,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 1000.w,
          child: const Text('Demo1'),
        ),
      ),
    );
  }
}
