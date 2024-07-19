import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
// constants
import 'package:flutter_app/constants/color.dart';
import 'package:flutter_app/constants/routerUtil.dart';
// webView
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// components
import 'package:flutter_app/components/header/index.dart';
// store
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_app/components/webView/webView.store.dart';
// utils
import 'package:flutter_app/utils/browser.dart';
import 'package:flutter_app/utils/shake.dart';
import './utils.dart';
// 导出
export 'package:flutter_app/components/header/index.dart';
export 'package:flutter_inappwebview/flutter_inappwebview.dart';

// T为具体widget
abstract class BasicWebView<T extends StatefulWidget> extends State<T> {
  String title = ''; // 头部
  String url = ''; // url
  bool isWillPop = true; // 是否监听 webview记录
  bool isCache = false; // 是否需要缓存

  GlobalKey? webViewKey = GlobalKey();
  InAppWebViewSettings settings = InAppWebViewSettings(
    // 跨平台配置
    useShouldOverrideUrlLoading: true, // 加载url拦截功能
    // useShouldInterceptAjaxRequest: true, // ajax请求拦截 打开会影响PNG电子加载
    // useOnLoadResource: true, // 资源加载回调
    transparentBackground: true, // 不要背景颜色
    allowFileAccessFromFileURLs: true, // 资源加载
    mediaPlaybackRequiresUserGesture: false, //多媒体控制
    // android平台配置
    useHybridComposition: true, // 支持HybridComposition
    useShouldInterceptRequest: true, // 支持资源拦截
    hardwareAcceleration: false, // 关闭硬件加速
    // iOS平台配置
    allowsInlineMediaPlayback: true,
  );

  @override
  void initState() {
    super.initState();

    // 获取数据
    getData();
  }

  // 获取对应的数据
  void getData();

  void onProgressChanged(InAppWebViewController controller, int progress) {
    webViewStore.progress = progress / 100;
  }

  void onLoadStart(InAppWebViewController controller, Uri? url) {
    this.url = url.toString();
    webViewStore.progress = 0.0;
  }

  void onLoadStop(InAppWebViewController controller, Uri? url) {
    this.url = url.toString();
    webViewStore.progress = 1.0;
  }

  void onUpdateVisitedHistory(
    InAppWebViewController controller,
    Uri? url,
    bool? androidIsReload,
  ) {
    this.url = url.toString();
  }

  // 拦截请求
  Future<NavigationActionPolicy?> shouldOverrideUrlLoading(
    InAppWebViewController controller,
    NavigationAction navigationAction,
  ) async {
    Uri uri = navigationAction.request.url!;
    if (![
      'http',
      'https',
      'file',
      'chrome',
      'data',
      'javascript',
      'about',
      'js-frame', // BB电游增加白名单
    ].contains(uri.scheme)) {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(
          Uri.parse(url),
          mode: LaunchMode.externalApplication,
        );
        return NavigationActionPolicy.CANCEL;
      }
    }
    return NavigationActionPolicy.ALLOW;
  }

  // 返回处理
  Future onPopInvoked(bool didPop) async {
    if (didPop) {
      return;
    }
    bool canBack = false;
    try {
      canBack = await controller.canGoBack();
      if (canBack) {
        // 当网页还有历史记录时，返回webview上一页
        await controller.goBack();
      }
    } catch (e) {
      // 如果webview加载报错不处理
    }
    if (!mounted) return false;
    // 返回原生页面上一页
    if (!canBack) {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      } else {
        routerUtil.onPushAndRemoveHome(context); //去首页
      }
    }
    return false;
  }

  // 头部左侧
  Widget renderLeading() {
    if (!isWillPop) {
      return const NavBack();
    }
    return NavBack(
      onPressed: () => onPopInvoked(false),
    );
  }

  // 头部左侧宽度
  double getLeadingWidth() => 36.0;

  // 头部右侧
  List<Widget>? renderActions() {
    return null;
  }

  // 头部
  PreferredSizeWidget? renderHeader() {
    return Header(
      leading: renderLeading(),
      leadingWidth: getLeadingWidth(),
      title: title,
      actions: renderActions(),
    );
  }

  // 内容
  List<Widget> renderBody() {
    return [];
  }

  // 刷新
  void onRefresh({
    InAppWebViewController? c,
  }) async {
    handleShake(); // 震动反馈
    if (Platform.isIOS) {
      (c ?? controller).loadUrl(urlRequest: URLRequest(url: WebUri(url)));
      return;
    }
    (c ?? controller).reload();
  }

  // webview控制器
  late InAppWebViewController controller;

  // 处理controller
  void handleController(InAppWebViewController _) async {}

  // 创建回调
  void onWebViewCreated(InAppWebViewController _) async {
    controller = _;
    addJavaScriptHandler(_, context);
    handleController(_);
  }

  // 注入js方法
  void addJavaScriptHandler(
    InAppWebViewController controller,
    BuildContext context,
  ) {
    controller.addJavaScriptHandler(
      handlerName: 'openAndroid', // 外跳到浏览器
      callback: (args) {
        print('url: ${args[0]}');
      },
    );
    controller.addJavaScriptHandler(
      handlerName: 'eventTracker', // 发送事件
      callback: (args) {
        print('eventType: ${args[0]}');
        print('eventValue: ${args[1]}');
      },
    );
  }

  // 安卓权限请求
  Future<PermissionResponse?> onPermissionRequest(
    InAppWebViewController controller,
    PermissionRequest permissionRequest,
  ) async {
    return PermissionResponse(
      action: PermissionResponseAction.GRANT,
      resources: permissionRequest.resources,
    );
  }

  // 安卓请求拦截
  Future<WebResourceResponse?> shouldInterceptRequest(
    InAppWebViewController controller,
    WebResourceRequest request,
  ) async {
    if (!isCache) {
      return null;
    }
    return handleAndroidShouldInterceptRequest(title, request);
  }

  // 内容区域
  Widget renderContent(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: renderHeader(),
      body: Stack(
        children: [
          url != ''
              ? InAppWebView(
                  key: webViewKey,
                  initialUrlRequest: URLRequest(url: WebUri(url)),
                  initialSettings: settings,
                  onWebViewCreated: onWebViewCreated,
                  onPermissionRequest: onPermissionRequest,
                  onLoadStart: onLoadStart,
                  onLoadStop: onLoadStop,
                  onProgressChanged: onProgressChanged, // 加载进度
                  onUpdateVisitedHistory: onUpdateVisitedHistory,
                  shouldOverrideUrlLoading: shouldOverrideUrlLoading,
                  shouldInterceptRequest: shouldInterceptRequest,
                )
              : Container(),
          // 进度条
          Observer(
            builder: (_) => LinearProgressIndicator(
              backgroundColor: ColorConstant.transparentColor,
              minHeight: 2,
              value: webViewStore.progress == 1.0 ? 0 : webViewStore.progress,
              valueColor: AlwaysStoppedAnimation<Color>(
                ColorConstant.primaryColor,
              ),
            ),
          ),
          ...renderBody(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!isWillPop) {
      return renderContent(context);
    }
    return PopScope(
      canPop: false,
      onPopInvoked: onPopInvoked, // android自带返回触发, 会禁止ios右滑返回
      child: renderContent(context),
    );
  }
}
