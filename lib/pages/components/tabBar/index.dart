import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
// flutter_screenutil
import 'package:flutter_screenutil/flutter_screenutil.dart';
// constants
import 'package:flutter_app/constants/device.dart';
// components
import 'package:flutter_app/components/image/index.dart';
// store
import 'package:flutter_app/pages/mine/message.store.dart';
// constants
import 'package:flutter_app/constants/color.dart';
import './constants.dart';

// 导出
export './constants.dart';

// 图片资源路径
String imgPath = 'assets/tabbar/';

class MyTabBar extends StatefulWidget {
  const MyTabBar({
    super.key,
    required this.pageController, //
  });

  final PageController pageController;

  @override
  MyTabBarState createState() => MyTabBarState();
}

class MyTabBarState extends State<MyTabBar> {
  int currentIndex = 0;
  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void onTap(int index) {
    if (index == currentIndex) {
      return;
    }
    HapticFeedback.lightImpact(); // 震动反馈
    widget.pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        bool isNoReadMessage = messageStore.isNoReadMessage;
        return BottomAppBar(
          shape: AutomaticNotchedShape(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15).r, // 圆角矩形
            ),
          ),
          color: const Color.fromRGBO(255, 255, 255, 0.9), // 导航栏背景颜色
          elevation: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround, // 均分底部导航栏横向空间
            children: tabList.asMap().entries.map((entry) {
              TabItem value = entry.value;
              bool isActive = currentIndex == entry.key;
              bool isBadge = entry.key == 4 && isNoReadMessage;
              return Expanded(
                child: InkWell(
                  child: SizedBox(
                    height: Device.bottomNavigationBarHeight,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8, bottom: 4).r,
                              child: MyImage(
                                src: imgPath +
                                    (isActive ? value.activeIcon : value.icon),
                                height: 21,
                              ),
                            ),
                            isBadge
                                ? const Positioned(
                                    top: 0,
                                    right: -5,
                                    child: MyImage(
                                      src:
                                          'assets/images/message/icon_no_read.png',
                                      width: 16,
                                      height: 16,
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                        Text(
                          value.label,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: isActive
                                ? ColorConstant.strongColor
                                : ColorConstant.normalColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () => onTap(entry.key),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
