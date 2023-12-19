import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
// flutter_easyloading
import 'package:flutter_easyloading/flutter_easyloading.dart';
// flutter_native_splash
import 'package:flutter_native_splash/flutter_native_splash.dart';
// pull_to_refresh
import 'package:pull_to_refresh/pull_to_refresh.dart';
// constants
import 'package:flutter_app/constants/color.dart';
import 'package:flutter_app/constants/routerId.dart';
// pages
import './pages/index.dart';
import './pages/common/splash/index.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // https://github.com/flutter/flutter/issues/101007
  await Future.delayed(const Duration(milliseconds: 300));
  // 强制竖屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // 加载app
  runApp(const MyApp());
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 统一路由切换IOS风格
  static const Map<TargetPlatform, PageTransitionsBuilder> defaultBuilders =
      <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerTriggerDistance: 60.0, // 头部触发刷新的越界距离
      maxOverScrollExtent: 80.0, // 头部最大可以拖动的范围
      child: MaterialApp(
        // 应用名称
        title: '测试',
        // 主题色
        theme: ThemeData(
          // 使用ios平台风格包括头部样式等<右滑返回>
          platform: TargetPlatform.iOS,
          // 默认字体
          fontFamily: 'PingFang SC',
          // 去除选中的波纹动画效果
          highlightColor: ColorConstant.transparentColor,
          splashColor: ColorConstant.transparentColor,
          // 统一路由切换
          pageTransitionsTheme:
              const PageTransitionsTheme(builders: defaultBuilders),
        ),
        initialRoute: routerId.splash,
        routes: <String, WidgetBuilder>{
          routerId.home: (BuildContext context) => const MainPage(),
          routerId.splash: (BuildContext context) => const SplashPage(),
        },
        builder: EasyLoading.init(
          builder: (context, child) {
            // 保证文字大小不受手机系统设置影响
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
        ),
      ),
    );
  }
}
