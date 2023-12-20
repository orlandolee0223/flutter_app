import 'dart:math';

import 'package:flutter/material.dart';
// constants
import 'package:flutter_app/constants/color.dart';
// components
import 'package:flutter_app/components/header/index.dart';
import 'package:flutter_app/components/asyncState/index.dart';

class Demo4Page extends StatefulWidget {
  const Demo4Page({super.key});

  @override
  Demo4PageState createState() => Demo4PageState();
}

class BackgroundColor extends CustomPainter {
  static const List<Color> colors = [
    Colors.orange,
    Colors.purple,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.red,
  ];

  final Size _size;
  BackgroundColor(this._size);

  @override
  void paint(Canvas canvas, Size size) {
    final Random rand = Random(12345);

    for (int i = 0; i < 10000; i++) {
      canvas.drawOval(
          Rect.fromCenter(
            center: Offset(
              rand.nextDouble() * _size.width - 100,
              rand.nextDouble() * _size.height,
            ),
            width: rand.nextDouble() * rand.nextInt(150) + 200,
            height: rand.nextDouble() * rand.nextInt(150) + 200,
          ),
          Paint()
            ..color = colors[rand.nextInt(colors.length)].withOpacity(0.3));
    }
  }

  @override
  bool shouldRepaint(BackgroundColor oldDelegate) => false;
}

class CursorPointer extends CustomPainter {
  final Offset _offset;

  CursorPointer(this._offset);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      _offset,
      10.0,
      Paint()..color = Colors.green,
    );
  }

  @override
  bool shouldRepaint(CursorPointer oldDelegate) =>
      oldDelegate._offset != _offset;
}

class Demo4PageState extends State<Demo4Page> with AsyncState<Demo4Page> {
  final GlobalKey _paintKey = GlobalKey();
  Offset _offset = Offset.zero;

  _updateOffset(PointerEvent event) {
    RenderBox? referenceBox =
        _paintKey.currentContext?.findRenderObject() as RenderBox;
    Offset offset = referenceBox.globalToLocal(event.position);
    setState(() {
      _offset = offset;
    });
  }

  bool isAnimateEnd = false;
  @override
  void initState() {
    super.initState();

    asyncWaitResume().then((value) {
      setState(() {
        isAnimateEnd = true;
      });
    });
  }

  Widget _buildBackground() {
    return RepaintBoundary(
      child: CustomPaint(
        painter: BackgroundColor(MediaQuery.of(context).size),
        isComplex: true,
        willChange: false,
      ),
    );
  }

  Widget _buildCursor() {
    return Listener(
      onPointerDown: _updateOffset,
      onPointerMove: _updateOffset,
      child: CustomPaint(
        key: _paintKey,
        painter: CursorPointer(_offset),
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: Header(
        title: 'Demo4',
        color: ColorConstant.strongColor,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: isAnimateEnd
            ? [
                _buildBackground(),
                _buildCursor(),
              ]
            : [],
      ),
    );
  }
}
