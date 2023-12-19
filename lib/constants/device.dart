// flutter_screenutil
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Device {
  // 屏幕宽
  static double screenWidth = 1.sw;
  // 屏幕高
  static double screenHeight = 1.sh;
  // 顶部状态栏, 随着刘海屏会增高
  static double statusBarHeight = ScreenUtil().statusBarHeight;
  // 头部高度 (舍弃小数, 避免出现和preferredSize设置偏差)
  static const double toolbarHeight = 44;
  // 头部真实高度
  static double toolbarRealityHeight = toolbarHeight.w.truncateToDouble();
  // 底部功能栏, 类似于iPhone XR 底部安全区域
  static double bottomBarHeight = ScreenUtil().bottomBarHeight;
  // 底部Navigation高度
  static double bottomNavigationBarHeight = 50.w;
  // 底部真实高度
  static double bottomBarRealityHeight = bottomBarHeight + bottomNavigationBarHeight;
  // 安全高度
  static double safeHeight = screenHeight - statusBarHeight - bottomBarHeight;
  // 实际的安全高度
  static double safeRealityHeight = safeHeight - toolbarRealityHeight - bottomNavigationBarHeight;
}
