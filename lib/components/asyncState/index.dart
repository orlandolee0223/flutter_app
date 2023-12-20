import 'dart:async';
import 'package:flutter/cupertino.dart';

// 进场动画卡顿
mixin AsyncState<T extends StatefulWidget> on State<T> {
  Completer resumeCompleter = Completer();

  @override
  void didChangeDependencies() {
    ModalRoute.of(context)!.controller?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        initAsyncLoad();
      }
    });
    super.didChangeDependencies();
  }

  // 动画是否结束
  Future asyncWaitResume() async {
    return resumeCompleter.future;
  }

  // 入场路由动画执行完成，新入场页面完全进入
  void initAsyncLoad() {
    resumeCompleter.complete(true);
  }
}
