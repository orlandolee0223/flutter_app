import 'package:flutter/material.dart';
// flutter_screenutil
import 'package:flutter_screenutil/flutter_screenutil.dart';
// constants
import 'package:flutter_app/constants/routerUtil.dart';
// components
import 'package:flutter_app/pages/components/tabBar/index.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    // 初始化路由
    routerUtil.init(context);
  }

  GlobalKey<MyTabBarState> myTabBarKey = GlobalKey();
  void onPageChanged(int index) {
    myTabBarKey.currentState?.onPageChanged(index);
  }

  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    // 初始化字体
    ScreenUtil.init(
      context,
      designSize: const Size(375, 667),
      minTextAdapt: true,
    );
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: pageList, // 禁止滑动
      ),
      bottomNavigationBar: MyTabBar(
        key: myTabBarKey,
        pageController: pageController,
      ),
    );
  }
}
