import 'package:mobx/mobx.dart';

// Include generated file
part 'webView.store.g.dart';

class WebViewStore = _WebViewStore with _$WebViewStore;

abstract class _WebViewStore with Store {
  @observable
  double progress = 0.0; // 全局信息

  // 初始化数据
  @action
  void handleProgress(double value) {
    progress = value;
  }
}

// 设置全局共享
final WebViewStore webViewStore = WebViewStore();
