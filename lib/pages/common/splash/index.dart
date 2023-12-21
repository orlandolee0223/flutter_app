import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// flutter_native_splash
import 'package:flutter_native_splash/flutter_native_splash.dart';
// constants
import 'package:flutter_app/constants/color.dart';
import 'package:flutter_app/constants/routerUtil.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    super.key,
  });

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    initDate();
  }

  Future<void> initDate() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    FlutterNativeSplash.remove(); // 数据加载成功才关闭Splash
    onFinish();
  }

  // 点击完成
  void onFinish() {
    routerUtil.onPushAndRemoveHome(context); // 重新定向到首页
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark, // 修改状态栏字体颜色
      child: Scaffold(
        backgroundColor: HexColor('#EFF7FF'),
        body: const Text(
          '引导页',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
