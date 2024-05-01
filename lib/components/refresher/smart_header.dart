import 'package:flutter/material.dart';
// pull_to_refresh
import 'package:pull_to_refresh/pull_to_refresh.dart';
// constants
import 'package:flutter_app/constants/color.dart';
// components
import 'package:flutter_app/components/refresher/loading.dart';

class SmartHeader extends StatelessWidget {
  const SmartHeader({
    super.key,
  });

  Widget renderContent(BuildContext context, RefreshStatus? mode) {
    if (mode == RefreshStatus.idle) {
      return Text(
        '↓ 下拉可刷新…',
        style: TextStyle(
          fontSize: 12,
          color: ColorConstant.normalColor,
        ),
      );
    }
    if (mode == RefreshStatus.canRefresh) {
      return Text(
        '↑ 松开手刷新…',
        style: TextStyle(
          fontSize: 12,
          color: ColorConstant.normalColor,
        ),
      );
    }
    if (mode == RefreshStatus.refreshing) {
      return const RefresherLoading(
        text: '正在拼命加载中…',
      );
    }
    if (mode == RefreshStatus.completed) {
      return Text(
        '- 加载成功 -',
        style: TextStyle(
          fontSize: 12,
          color: ColorConstant.normalColor,
        ),
      );
    }
    if (mode == RefreshStatus.failed) {
      return Text(
        '- 刷新失败 -',
        style: TextStyle(
          fontSize: 12,
          color: ColorConstant.warningColor,
        ),
      );
    }
    return const Text('');
  }

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      height: 40,
      builder: (BuildContext context, RefreshStatus? mode) {
        return SizedBox(
          height: 40,
          child: Center(
            child: renderContent(context, mode),
          ),
        );
      },
    );
  }
}
