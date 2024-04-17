import 'package:flutter/material.dart';
// constants
import 'package:flutter_app/constants/color.dart';
// components
import 'package:flutter_app/components/header/index.dart';
import './components/index.dart';

class Demo5Page extends StatefulWidget {
  const Demo5Page({super.key});

  @override
  Demo5PageState createState() => Demo5PageState();
}

class Demo5PageState extends State<Demo5Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: Header(
        title: 'Demo5',
        color: ColorConstant.strongColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 100),
            InkWell(
              onTap: () {
                DemoModal.showCardForm(context);
              },
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorConstant.primaryColor,
                ),
                alignment: Alignment.center,
                child: const Text(
                  '点击',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
