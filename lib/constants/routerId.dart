// ignore_for_file: file_names

class RouterId {
  final String splash; // 引导页
  final String home; // 首页

  const RouterId({
    required this.splash,
    required this.home,
  });
}

// 设置全局共享
RouterId routerId = const RouterId(
  splash: '/splash',
  home: '/',
);
