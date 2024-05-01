import 'package:flutter/material.dart';
// constants
import 'package:flutter_app/constants/color.dart';
// components
import 'package:flutter_app/components/header/index.dart';
import './list/index.dart';

class Demo6Page extends StatefulWidget {
  const Demo6Page({super.key});

  @override
  Demo6PageState createState() => Demo6PageState();
}

class Demo6PageState extends State<Demo6Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: Header(
        title: 'Demo6',
        color: ColorConstant.strongColor,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          // 返回一个 Sliver 数组给外部可滚动组件。
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                toolbarHeight: 1,
                expandedHeight: 180,
                elevation: 0,
                titleSpacing: 0,
                clipBehavior: Clip.none,
                title: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 180,
                        child: Column(
                          children: [
                            Container(
                              color: Colors.amber.withOpacity(0.5),
                              height: 60,
                              child: const Center(child: Text('Header 1')),
                            ),
                            Container(
                              color: Colors.amber.withOpacity(0.8),
                              height: 60,
                              child: const Center(child: Text('Header 2')),
                            ),
                            Container(
                              color: Colors.amber,
                              height: 60,
                              child: const Center(child: Text('Header 3')),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: const ListDemo(),
      ),
    );
  }
}
