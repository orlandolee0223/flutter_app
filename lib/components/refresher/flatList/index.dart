import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// pull_to_refresh
import 'package:pull_to_refresh/pull_to_refresh.dart';
// constants
import './constants.dart';
// components
import 'package:flutter_app/components/loading/index.dart';
import 'package:flutter_app/components/refresher/smart_header.dart';
import 'package:flutter_app/components/refresher/flatList/smart_footer.dart';

// export
export 'package:pull_to_refresh/pull_to_refresh.dart';
export './constants.dart';

// M 为数据模型 T为具体widget
abstract class FlatList<M, T extends StatefulWidget> extends State<T> {
  int pageIndex = 1;

  // 控制器
  late RefreshController refreshController;

  // 数据模型
  List<M> list = [];

  List<M>? cacheList;

  // 是第一次
  bool isFirst = true;

  // 切换是否展示空
  bool isEmpty = false;

  late ScrollController scrollController;

  bool needScroll = true;

  bool isScrolling = false;
  GlobalKey listViewKey = GlobalKey();

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();

    // 初始化refreshController
    refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void dispose() {
    refreshController.dispose();
    scrollController.dispose();

    super.dispose();
  }

  void onRefresh() async {
    loadData(forceRefresh: true);
  }

  void onLoading() async {
    loadData(loadMore: true);
  }

  Future<void> loadData({
    bool loadMore = false, // 是否加载更多数据
    bool forceRefresh = false, // 是否刷新缓存
  }) async {
    if (!loadMore) {
      pageIndex = 1;
      setState(() {
        isFirst = true;
      });
    }
    int currIndex = pageIndex + (loadMore ? 1 : 0);
    try {
      List<M> result = await getData(currIndex, flatListPageSize, forceRefresh);
      if (loadMore) {
        if (result.isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      }
      if (forceRefresh) {
        refreshController.refreshCompleted();
      }
      if (!mounted) return;
      var refreshData = true;
      if (!needScroll && isScrolling) {
        refreshData = false;
        if (loadMore) {
          cacheList = [...list, ...result];
          pageIndex++;
        } else {
          cacheList = result;
        }
      }
      if (refreshData) {
        setState(() {
          if (loadMore) {
            // 合成新数组
            list = [...list, ...result];
            if (result.isNotEmpty) {
              pageIndex++;
            }
          } else {
            list = result;
            refreshController.refreshCompleted(resetFooterState: true);
          }
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        if (loadMore) {
          refreshController.loadFailed();
        } else {
          refreshController.refreshFailed();
        }
        if (forceRefresh) {
          refreshController.refreshCompleted();
        }
      });
    }
    if (!mounted) return;
    setState(() {
      isFirst = false;
    });
  }

  void loadViewData(List<M> result) {
    setState(() {
      list = result;
    });
  }

  //获取对应页吗的数据
  Future<List<M>> getData(int pageIndex, int pageSize, bool forceRefresh);

  // 返回条目
  Widget renderItem(BuildContext context, int index, M item);

  // 返回加载容器
  Widget renderLoading() {
    return const Center(
      child: Loading(width: 40),
    );
  }

  // 渲染列表为空内容(默认)
  Widget renderEmpty() {
    return const Center(
      child: Text('暂无数据'),
    );
  }

  // 返回listView
  Widget renderListView() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: filterList(list).length,
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      itemBuilder: (BuildContext context, int index) {
        return renderItem(context, index, filterList(list)[index]);
      },
    );
  }

  // 列表过滤
  List<M> filterList(List<M> list) => list;

  // 返回滚动内容区域
  Widget renderContent(BuildContext context) {
    // 有数据
    bool hasData = filterList(list).isNotEmpty;
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: hasData,
      //数据为空就不下拉加载了
      header: const SmartHeader(),
      footer: SmartFooter(
        onRequestLoading: () {
          refreshController.requestLoading();
        },
      ),
      controller: refreshController,
      onRefresh: onRefresh,
      onLoading: onLoading,
      child: !hasData
          // 不展示空组件
          ? isEmpty
              ? Container()
              : isFirst
                  ? renderLoading()
                  : renderEmpty()
          : renderListView(),
    );
  }
}
