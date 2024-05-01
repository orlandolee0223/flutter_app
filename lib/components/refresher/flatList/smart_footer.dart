import 'package:flutter/material.dart';
// pull_to_refresh
import 'package:pull_to_refresh/pull_to_refresh.dart';
// constants
import 'package:flutter_app/constants/color.dart';
// components
import 'package:flutter_app/components/refresher/loading.dart';

class SmartFooter extends StatelessWidget {
  const SmartFooter({
    super.key,
    required this.onRequestLoading,
  });

  final VoidCallback onRequestLoading;

  Widget renderContent(BuildContext context, LoadStatus? mode) {
    if (mode == LoadStatus.loading) {
      return const RefresherLoading(
        text: '加载更多…',
      );
    }
    if (mode == LoadStatus.failed) {
      return InkWell(
        onTap: onRequestLoading,
        child: Text(
          '加载失败，点击重新加载',
          style: TextStyle(
            fontSize: 12,
            color: ColorConstant.warningColor,
          ),
        ),
      );
    }
    if (mode == LoadStatus.noMore) {
      return Text(
        '- 我是有底线的 -',
        style: TextStyle(
          fontSize: 12,
          color: ColorConstant.normalColor,
        ),
      );
    }
    return const Text('');
  }

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      height: 40,
      builder: (BuildContext context, LoadStatus? mode) {
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
