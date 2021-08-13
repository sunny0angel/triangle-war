import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  final String imageName;

  AnimatedBackground(this.imageName);

  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  //动画控制器
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    //AnimationController是一个特殊的Animation对象，在屏幕刷新的每一帧，就会生成一个新的值，
    // 默认情况下，AnimationController在给定的时间段内会线性的生成从0.0到1.0的数字
    //用来控制动画的开始与结束以及设置动画的监听
    //vsync参数，存在vsync时会防止屏幕外动画（动画的UI不在当前屏幕时）消耗不必要的资源
    //duration 动画的时长，这里设置的 seconds: 2 为2秒，当然也可以设置毫秒 milliseconds：2000.
    controller =
        AnimationController(duration: const Duration(seconds: 20), vsync: this)
          ..forward()
          ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotationTransition(
        //设置动画的旋转中心
        alignment: Alignment.center,
        //动画控制器
        turns: controller,
        //将要执行动画的子view
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Image.asset(
              widget.imageName,
              height: 5000,
            ),
          ],
        ),
        // Image.asset(widget.imageName),
      ),
    );
  }
}
