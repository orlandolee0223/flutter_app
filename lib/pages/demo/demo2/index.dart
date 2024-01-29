import 'package:flutter/material.dart';
// constants
import 'package:flutter_app/constants/color.dart';
// components
import 'package:flutter_app/components/header/index.dart';
import 'package:flutter_app/components/image/index.dart';

class Demo2Page extends StatefulWidget {
  const Demo2Page({super.key});

  @override
  Demo2PageState createState() => Demo2PageState();
}

class Demo2PageState extends State<Demo2Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: Header(
        title: 'Demo2',
        color: ColorConstant.strongColor,
      ),
      body: const SingleChildScrollView(
        child: MyImage(
          width: double.infinity,
          src: 'https://img95.699pic.com/photo/40253/4274.jpg_wh860.jpg',
        ),
      ),
    );
  }
}
