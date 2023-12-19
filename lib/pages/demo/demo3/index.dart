import 'package:flutter/material.dart';
// components
import 'package:flutter_app/components/webView/index.dart';

class Demo3Page extends StatefulWidget {
  const Demo3Page({super.key});

  @override
  Demo3PageState createState() => Demo3PageState();
}

class Demo3PageState extends BasicWebView<Demo3Page> {
  @override
  void getData() {
    setState(() {
      title = 'Demo3';
      url = 'https://juejin.cn/post/7066954522655981581';
    });
  }
}
