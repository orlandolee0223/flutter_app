import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// constants
import '../constants.dart';

class RouteConfig {
  late Offset offset;
  late double circleRadius;

  RouteConfig.fromContext(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject()! as RenderBox;
    offset = renderBox.localToGlobal(renderBox.size.center(Offset.zero));
    if (offset.dx > MediaQuery.of(context).size.width / 2) {
      if (offset.dy > MediaQuery.of(context).size.height / 2) {
        circleRadius = sqrt(pow(offset.dx, 2) + pow(offset.dy, 2)).toDouble();
      } else {
        circleRadius = sqrt(
          pow(offset.dx, 2) +
              pow(MediaQuery.of(context).size.height - offset.dy, 2),
        ).toDouble();
      }
    }
    if (offset.dx <= MediaQuery.of(context).size.width / 2) {
      if (offset.dy > MediaQuery.of(context).size.height / 2) {
        circleRadius = sqrt(
          pow(MediaQuery.of(context).size.width - offset.dx, 2) +
              pow(offset.dy, 2),
        ).toDouble();
      } else {
        circleRadius = sqrt(
          pow(MediaQuery.of(context).size.width - offset.dx, 2) +
              pow(MediaQuery.of(context).size.height - offset.dy, 2),
        ).toDouble();
      }
    }
  }
}

class RippleRoute extends PageRoute {
  RippleRoute({
    required this.builder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
    required this.routeConfig,
  });

  final RouteConfig routeConfig;

  final WidgetBuilder builder;

  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color? barrierColor;

  @override
  final String? barrierLabel;

  @override
  final bool maintainState;

  bool isPopGestureInProgress(PageRoute<dynamic> route) {
    return route.navigator!.userGestureInProgress;
  }

  @override
  bool canTransitionTo(TransitionRoute<dynamic> nextRoute) {
    // Don't perform outgoing animation if the next route is a fullscreen dialog.
    return (nextRoute is MaterialRouteTransitionMixin &&
            !nextRoute.fullscreenDialog) ||
        (nextRoute is CupertinoRouteTransitionMixin &&
            !nextRoute.fullscreenDialog);
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) =>
      builder(context);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    final bool linearTransition = isPopGestureInProgress(this);
    return SlideTransition(
      position: (linearTransition
              ? secondaryAnimation
              : CurvedAnimation(
                  parent: secondaryAnimation,
                  curve: Curves.linearToEaseOut,
                  reverseCurve: Curves.easeInToLinear,
                ))
          .drive(packetMiddleLeftTween), // 动画缩放值的变化
      textDirection: Directionality.of(context), // 动画执行的位置关系
      transformHitTests: false, // 点击事件是否落在动画后的控件上
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: routeConfig.offset.dy -
                routeConfig.circleRadius * animation.value,
            left: routeConfig.offset.dx -
                routeConfig.circleRadius * animation.value,
            child: SizedBox(
              height: routeConfig.circleRadius * 2 * animation.value,
              width: routeConfig.circleRadius * 2 * animation.value,
              child: ClipOval(
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: routeConfig.circleRadius * animation.value -
                          routeConfig.offset.dy,
                      left: routeConfig.circleRadius * animation.value -
                          routeConfig.offset.dx,
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: child,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
