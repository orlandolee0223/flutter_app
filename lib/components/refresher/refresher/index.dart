import 'package:flutter/material.dart';
// pull_to_refresh
import 'package:pull_to_refresh/pull_to_refresh.dart';
// components
import 'package:flutter_app/components/refresher/smart_header.dart';
import 'package:flutter_app/components/loading/index.dart';

class Refresher extends StatefulWidget {
  const Refresher({
    super.key,
    this.initialRefresh = false,
    this.isNeedGetData = true,
    this.isNotEmpty = true,
    this.empty,
    required this.onRefresh,
    this.child,
    this.renderLoading,
  });

  final bool? initialRefresh; // 初始化是否加载loading
  final bool? isNeedGetData; // 是否需要初始化加载获取数据
  final bool? isNotEmpty; // 内容是否为空
  final Widget? empty; // 内容为空
  final Future Function({bool forceRefresh}) onRefresh; // 需要一个Future方法注入
  final Widget? child; // 子元素
  final Widget? renderLoading; // 自定义loading

  @override
  RefresherState createState() => RefresherState();
}

class RefresherState extends State<Refresher> {
  // 控制器
  late RefreshController refreshController;
  // 第一次加载
  late bool isFirst = widget.initialRefresh!;
  // 第一次显示下拉刷新
  late bool isInitial = widget.initialRefresh!;

  @override
  void initState() {
    super.initState();

    refreshController = RefreshController(
      initialRefresh: widget.initialRefresh!,
    );

    // 初始化不需要加载数据并且
    if (widget.initialRefresh == false && widget.isNeedGetData == true) {
      // 避免上层组件渲染完成, 调用报错
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onGetData();
      });
    } else {
      isFirst = true; // 不内部请求, 不需要loading
    }
  }

  // 获取数据
  void onGetData() async {
    await widget.onRefresh(forceRefresh: false).whenComplete(() {
      if (!mounted) return;
      setState(() {
        isFirst = true;
      });
    });
  }

  // 刷新
  void onRefresh() async {
    try {
      await widget.onRefresh(forceRefresh: true);
      refreshController.refreshCompleted();
    } catch (e) {
      refreshController.refreshFailed();
    }
    if (!mounted) return;
    setState(() {
      isInitial = false;
    });
  }

  // 滚动距离
  void handleAnimateTo({
    double? top,
    bool isMax = true,
  }) async {
    refreshController.position?.animateTo(
      top ??
          (isMax
              ? refreshController.position!.maxScrollExtent
              : refreshController.position!.minScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  Widget? renderContent() {
    // 数据不为空, 返回列表
    if (widget.isNotEmpty!) {
      return widget.child;
    }
    // 如果处理初始化下拉
    if (isInitial) {
      return null;
    }
    // 数据为空, 第一次未加载成功
    if (!isFirst) {
      if (widget.renderLoading != null) {
        return widget.renderLoading;
      }
      return const Center(
        child: Loading(width: 40),
      );
    }
    // 如果传入空元素
    if (widget.empty != null) {
      return widget.empty;
    }
    // 展示默认空数据
    return const Center(
      child: Text('暂无数据'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      header: const SmartHeader(),
      controller: refreshController,
      onRefresh: onRefresh,
      child: renderContent(),
    );
  }
}
