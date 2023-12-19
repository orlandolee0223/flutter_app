import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// flutter_screenutil
import 'package:flutter_screenutil/flutter_screenutil.dart';
// constants
import 'package:flutter_app/constants/color.dart';
import 'package:flutter_app/constants/device.dart';
// components
import 'package:flutter_app/components/image/index.dart';

class NavBack extends StatelessWidget {
  const NavBack({
    super.key,
    this.onPressed,
    this.isScreen = true,
  });

  final VoidCallback? onPressed; // 可自定义返回事件
  final bool isScreen; // 是否需要单位

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: InkWell(
        child: Row(
          children: [
            Padding(
              padding: isScreen
                  ? const EdgeInsets.symmetric(horizontal: 14).r
                  : const EdgeInsets.symmetric(horizontal: 14),
              child: MyImage(
                src: 'assets/header/icon_arrowleft_nor.png',
                width: 8.0,
                isScreen: isScreen,
              ),
            ),
          ],
        ),
        onTap: () {
          if (onPressed is Function) {
            onPressed!();
            return;
          }
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({
    super.key,
    this.leading,
    this.leadingWidth = 36.0,
    this.automaticallyImplyLeading = true,
    this.title,
    this.toolbarHeight = Device.toolbarHeight,
    this.elevation = 0,
    this.backgroundColor,
    this.color,
    this.bottom,
    this.actions,
    this.leftOnPressed,
    this.isScreen = true,
    this.systemOverlayStyle,
  });

  final Widget? leading; // 左边返回
  final double? leadingWidth;
  final bool automaticallyImplyLeading; // 没有leading并且为false, 空调留给title
  final dynamic title; // 头部文案
  final double toolbarHeight; // 高度
  final double elevation; // 导航栏阴影
  final Color? backgroundColor; // 背景颜色
  final Color? color; // 字体颜色
  final VoidCallback? leftOnPressed; // 左侧返回操作
  final PreferredSizeWidget? bottom; // 底部
  final List<Widget>? actions; // 右侧附加的部分
  final bool isScreen; // 是否需要单位
  final SystemUiOverlayStyle? systemOverlayStyle; // 状态栏颜色 light-白色 dark-黑色

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading == null && automaticallyImplyLeading == false
          ? null
          : leading ??
              NavBack(
                onPressed: leftOnPressed,
                isScreen: isScreen,
              ),
      leadingWidth: isScreen ? leadingWidth?.w : leadingWidth, // leading的宽度
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: true,
      titleSpacing: 0.0, // 撑开左右两边的距离
      title: title is String
          ? Text(
              title!,
              style: TextStyle(
                fontSize: isScreen ? 18.sp : 18,
                fontWeight: FontWeight.w400,
                color: color ?? ColorConstant.strongColor,
              ),
            )
          : title is Widget
              ? title
              : Container(),
      toolbarHeight: isScreen
          ? toolbarHeight.w.truncateToDouble()
          : toolbarHeight, // 舍弃小数, 避免出现和preferredSize设置偏差
      elevation: elevation,
      backgroundColor: backgroundColor ?? ColorConstant.backgroundColor,
      bottom: bottom,
      actions: actions,
      systemOverlayStyle: systemOverlayStyle ?? (SystemUiOverlayStyle.dark),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      isScreen ? toolbarHeight.w.truncateToDouble() : toolbarHeight);
}
