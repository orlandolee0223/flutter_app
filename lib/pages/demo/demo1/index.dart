import 'package:flutter/material.dart';
// flutter_screenutil
import 'package:flutter_screenutil/flutter_screenutil.dart';
// constants
import 'package:flutter_app/constants/color.dart';
// components
import 'package:flutter_app/components/header/index.dart';

import '../demo2/index.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 12).r,
        child: SizedBox(
          height: 1000.w,
          child: Column(
            children: <Widget>[
              const Text('Demo1'),
              Container(
                width: double.infinity,
                height: 50.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12).r,
                  color: ColorConstant.primaryColor,
                ),
                margin: const EdgeInsets.symmetric(vertical: 12).r,
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Demo2Page(),
                      ),
                    );
                  },
                  child: const Text('Demo2'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
