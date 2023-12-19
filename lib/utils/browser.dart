import 'package:url_launcher/url_launcher.dart';
// 导出
export 'package:url_launcher/url_launcher.dart';

Future<void> launchInBrowser(String url) async {
  // 如果可以则启动
  await launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
  );
}
