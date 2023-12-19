// ignore_for_file: file_names

import 'package:flutter/material.dart';
// components
import 'package:flutter_app/components/pageRoute/fadePageRoute/index.dart';
import 'package:flutter_app/components/pageRoute/rippleRoute/index.dart';
// pages
import 'package:flutter_app/pages/signIn/index.dart';
import 'package:flutter_app/pages/index.dart';

class RouterUtil {
  late BuildContext context;

  // 初始化
  void init(BuildContext value) {
    context = value;
  }

  // 去登录
  void onPushSignIn(BuildContext? _) {
    Navigator.push(
      _ ?? context,
      RippleRoute(
        builder: (context) => const SignInPage(),
        routeConfig: RouteConfig.fromContext(_ ?? context),
      ),
    );
  }

  // 其他路由出栈, home进栈
  void onPushAndRemoveHome(BuildContext? _) {
    Navigator.pushAndRemoveUntil(
      _ ?? context,
      RippleRoute(
        builder: (context) => const MainPage(),
        routeConfig: RouteConfig.fromContext(_ ?? context),
      ),
      (_) => false, // 之前路由全部出栈
    );
  }

  // 其他路由出栈, Home进栈
  void onPushAndRemoveFadeHome(BuildContext? _) {
    Navigator.pushAndRemoveUntil(
      _ ?? context,
      FadePageRoute(
        builder: (context) => const MainPage(),
      ),
      (_) => false, // 之前路由全部出栈
    );
  }

  // 其他路由出栈, Home进栈
  void onPushAndRemoveHome1(BuildContext? _) {
    Navigator.pushAndRemoveUntil(
      _ ?? context,
      MaterialPageRoute(
        builder: (context) => const MainPage(),
      ),
      (_) => false, // 之前路由全部出栈
    );
  }

  // 去存款
  void onPushDeposit() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInPage(),
      ),
    );
  }
}

// 设置全局共享
RouterUtil routerUtil = RouterUtil();
