// pages
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/pages/home/index.dart';
import 'package:flutter_app/pages/demo/index.dart';

class TabItem {
  final String label;
  final String icon;
  final String activeIcon;
  final Widget? page;

  const TabItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    this.page,
  });
}

// 导航list
List<TabItem> _tabList = const <TabItem>[
  TabItem(
    label: '首页',
    icon: 'icon_01_nor.png',
    activeIcon: 'icon_01_sel.png',
    page: HomePage(),
  ),
  TabItem(
    label: 'Demo',
    icon: 'icon_02_nor.png',
    activeIcon: 'icon_02_sel.png',
    page: DemoPage(),
  ),
];

// 页面列表
List<Widget> pageList = _tabList.fold<List<Widget>>([], (prev, curr) {
  if (curr.page != null) {
    prev.add(curr.page!);
  }
  return prev;
});

// 按钮列表
List<TabItem> tabList = _tabList.fold<List<TabItem>>([], (prev, curr) {
  if (curr.page != null) {
    prev.add(TabItem(
      label: curr.label,
      icon: curr.icon,
      activeIcon: curr.activeIcon,
    ));
  }
  return prev;
});
