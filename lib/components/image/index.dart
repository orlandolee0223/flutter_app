import 'package:flutter/material.dart';
// flutter_screenutil
import 'package:flutter_screenutil/flutter_screenutil.dart';
// cached_network_image
import 'package:cached_network_image/cached_network_image.dart';

/* 基础image组件
* 1. 支持本地图片加载
* 2. 支持网络图片加载和网络缓存, 因为要加载展位图, 不指定宽高, 会默认拿外层容器宽度
*    如果外层容器无宽高限制, 需指定宽高, 否则展位图不显示
* */
class MyImage extends StatelessWidget {
  const MyImage({
    super.key,
    required this.src,
    this.width,
    this.height,
    this.fit, // 展现方式
    this.onPressed, // 回调
    this.isScreen = true, // 是否需要单位
    this.customErrorImage, //设置图片加载失败预设图片
    this.customPreloadImage, //预加载的默认本地展位图
  });

  final String src; // 图片地址
  final double? width; // 图片宽度 double
  final double? height; // 图片高度 double
  final BoxFit? fit;
  final VoidCallback? onPressed;
  final bool isScreen;
  final String? customErrorImage;
  final String? customPreloadImage;

  Widget renderContent() {
    // 如果是网络图片
    if (src.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: src,
        width: isScreen ? width?.w : width,
        height: isScreen ? height?.w : height,
        fit: fit,
        placeholder: (context, url) => Image.asset(
          customPreloadImage ?? 'assets/image/default.png',
          fit: BoxFit.cover,
        ),
        errorWidget: (context, url, error) => Image.asset(
          customErrorImage ?? 'assets/image/default.png',
          fit: BoxFit.cover,
        ),
      );
    }
    print('src: $src');
    // 如果是本地图片
    return RepaintBoundary(
      child: Image.asset(
        src,
        width: isScreen ? width?.w : width,
        height: isScreen ? height?.w : height,
        fit: fit,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (onPressed is Function) {
      return InkWell(
        onTap: onPressed,
        child: renderContent(),
      );
    }
    return renderContent();
  }
}
