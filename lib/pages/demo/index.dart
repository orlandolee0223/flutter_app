import 'package:flutter/material.dart';
// flutter_screenutil
import 'package:flutter_screenutil/flutter_screenutil.dart';
// constants
import 'package:flutter_app/constants/color.dart';
// components
import 'package:flutter_app/components/header/index.dart';
// pages
import 'package:flutter_app/pages/demo/demo1/index.dart';
import 'package:flutter_app/pages/demo/demo2/index.dart';
import 'package:flutter_app/pages/demo/demo3/index.dart';
import 'package:flutter_app/pages/demo/demo4/index.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  DemoPageState createState() => DemoPageState();
}

class DemoPageState extends State<DemoPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // 保持应用状态

  Widget renderNavItem({
    isLast = false,
    page,
    text,
  }) {
    return Container(
      width: double.infinity,
      height: 50.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12).r,
        color: ColorConstant.primaryColor,
      ),
      margin: isLast ? null : const EdgeInsets.only(bottom: 12).r,
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ),
          );
        },
        child: text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: Header(
        title: 'Demo',
        color: ColorConstant.strongColor,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12).r,
        child: SizedBox(
          height: 1000.w,
          child: Column(
            children: <Widget>[
              renderNavItem(
                page: const Demo1Page(),
                text: const Text('Demo1'),
              ),
              renderNavItem(
                page: const Demo2Page(),
                text: const Text('Demo2'),
              ),
              renderNavItem(
                page: const Demo3Page(),
                text: const Text('Demo3'),
              ),
              renderNavItem(
                isLast: true,
                page: const Demo4Page(),
                text: const Text('Demo4'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
