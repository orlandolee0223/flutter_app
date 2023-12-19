import 'dart:typed_data';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// path_provider
import 'dart:io';
import 'package:path_provider/path_provider.dart';
// crypto
import 'dart:convert';
import 'package:crypto/crypto.dart';
// utils
import 'package:dio/dio.dart';

// 写入指定文件中
void _writeDataToFile(File file, String data) async {
  await file.writeAsString(data);
}

// 读取文件
Future<Uint8List> _getDataByFile(File file) async {
  return file.readAsBytes();
}

// 处理安卓静态资源缓存
Future<WebResourceResponse?> handleAndroidShouldInterceptRequest(
  String title,
  WebResourceRequest request,
) async {
  String url = request.url.toString();
  bool isJs = url.endsWith('.js');
  if (isJs || url.endsWith('.css')) {
    // 去掉域名
    String pathname = Uri.parse(url).path;
    String key = md5.convert(utf8.encode('${title}_$pathname')).toString();
    // 获取文件夹
    Directory directory = await getApplicationDocumentsDirectory();
    String directoryPath = directory.path;
    File file = File('$directoryPath/$key');
    if (!file.existsSync()) {
      file.createSync();
    }
    Uint8List cacheData = await _getDataByFile(file);
    // 直接使用本地缓存
    if (cacheData.isNotEmpty) {
      return WebResourceResponse(
        data: cacheData,
        contentType:
            isJs ? 'application/javascript; charset=UTF-8' : 'text/css',
      );
    }
    // 没缓存, 后台去请求, 不拦截
    Dio().get(url).then((data) {
      _writeDataToFile(file, '$data');
    });
  }
  return null;
}
