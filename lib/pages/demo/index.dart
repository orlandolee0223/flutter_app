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
        child: SizedBox(
          height: 1000.w,
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 50.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12).r,
                  color: ColorConstant.primaryColor,
                ),
                margin: const EdgeInsets.only(bottom: 14).r,
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Demo1Page(),
                      ),
                    );
                  },
                  child: const Text('Demo1'),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12).r,
                  color: ColorConstant.primaryColor,
                ),
                margin: const EdgeInsets.only(bottom: 14).r,
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
              Container(
                width: double.infinity,
                height: 50.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12).r,
                  color: ColorConstant.primaryColor,
                ),
                margin: const EdgeInsets.only(bottom: 14).r,
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Demo3Page(),
                      ),
                    );
                  },
                  child: const Text('Demo3'),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12).r,
                  color: ColorConstant.primaryColor,
                ),
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Demo4Page(),
                      ),
                    );
                  },
                  child: const Text('Demo4'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
