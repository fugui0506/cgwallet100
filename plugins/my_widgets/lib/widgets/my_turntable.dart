import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class MyTurntable extends StatefulWidget {
  const MyTurntable({
    super.key,
    required this.onSetReward,
    required this.items,
    required this.radius,
    this.onResult,
    this.onError,
    this.pointer,
    this.lights,
  });

  final Future<int?> Function() onSetReward;
  final void Function(MySectorItem)? onResult;
  final void Function()? onError;
  final Widget? pointer;
  final List<MySectorItem> items;
  final double radius;
  final List<Widget>? lights;

  @override
  State<MyTurntable> createState() => _MyTurntableState();
}

class _MyTurntableState extends State<MyTurntable> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animationSpinner;

  int? _index;
  bool _isSpinning = false;

  int _lightIndex = 0;
  Timer? _lightTimer;

  @override
  void initState() {
    // 初始化 controller
    _animationController = AnimationController(
      vsync: this,
    );

    // 初始化 animation
    _animationSpinner = Tween<double>(
      begin: 0,
      end: 0,
    ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear
    ));

    super.initState();
  }

  @override
  void dispose() {
    _animationController.stop();
    _animationController.dispose();
    super.dispose();
  }

  void _startLightAnimation() {
    _lightTimer = Timer.periodic( const Duration(milliseconds: 200), (timer) {
      setState(() {
        _lightIndex = widget.lights == null || widget.lights!.isEmpty ? 0 : (_lightIndex + 1) % widget.lights!.length;
      });
    });
  }

  void _stopLightAnimation() {
    _lightTimer?.cancel();
    _lightTimer = null;
  }

  // duration: 转动时间
  // rounds: 转动圈数
  // angle: 停止的角度也就是中奖角度
  // curve: 动画的类型
  Future<void> _startSpin(double duration, int rounds, double angle, Curve curve) async {
    _animationController.duration = Duration(milliseconds: (duration * 1000).toInt());

    _animationSpinner = Tween<double>(
      begin: 0,
      end: rounds * 2 * math.pi + angle * math.pi / 180,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: curve,
    ));

    _animationController.reset();
    await _animationController.forward();
  }

  Future<void> _onSetReward() async {
    final index = await widget.onSetReward();
    if (index == null) {
      widget.onError?.call();
      _animationController.stop();
      _animationController.reset();
      _isSpinning = false;
      _stopLightAnimation();
      return;
    } else {
      _index = index;

      final angleEach = 360 / widget.items.length;
      final startAngleRad = index * angleEach + angleEach / 6;
      final sweepAngleRad = (index + 1) * angleEach - angleEach / 6;

      final random = math.Random();
      final angle = startAngleRad + (sweepAngleRad - startAngleRad) * random.nextDouble();

      await _startSpin(4, 6, 360 - angle, Curves.linearToEaseOut);
      _index = null;
      _isSpinning = false;
      _stopLightAnimation();
      widget.onResult?.call(widget.items[index]);
    }
  }

  Future<void> _handleGo() async {
    if (_isSpinning) {
      log('正转着呢，急个啥...');
      return;
    }

    if (widget.items.isEmpty) {
      log('都没有东西，你让我转啥呢...');
      return;
    }

    _isSpinning = true;
    _startLightAnimation();
    _onSetReward();
    // 持续匀速转动
    while (_index == null) {
      await _startSpin(1, 8, 0, Curves.linear);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Container(
        constraints: BoxConstraints(maxWidth: widget.radius, maxHeight: widget.radius),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(
            color: Colors.brown.withOpacity(0.2),
            // spreadRadius: 2,
            offset: const Offset(0, 0),
            blurRadius: 24,
          )],
        ),
        child: AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: widget.lights?[_lightIndex],
        ),
      ),

      Container(
        constraints: BoxConstraints(maxWidth: widget.radius, maxHeight: widget.radius),
        child: LayoutBuilder(builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxWidth,
            padding: EdgeInsets.all(constraints.maxWidth * 24 / 200),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(
                  color: Colors.deepOrange.withOpacity(0.5),
                  offset: const Offset(0, 0),
                  blurRadius: 8,
                )],
              ),
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) => Transform.rotate(
                  angle: _animationSpinner.value,
                  child: widget.items.isEmpty
                      ? CircleAvatar(radius: constraints.maxWidth, backgroundColor: Colors.deepOrangeAccent)
                      : CustomPaint(size: Size(constraints.maxWidth , constraints.maxWidth), painter: MyCustomPainter(list: widget.items)),
                ),
              ),
            ),
          );
        }),
      ),

      IconButton(
        constraints: BoxConstraints(maxWidth: widget.radius * 80 / 200, maxHeight: widget.radius * 80 / 200),
        onPressed: _handleGo,
        icon: widget.pointer ?? const SizedBox(),
      ),
    ]);
  }
}

class MyCustomPainter extends CustomPainter {
  final List<MySectorItem> list;

  MyCustomPainter({
    required this.list
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 每一个扇形的角度
    final angle = 360 / list.length;

    list.asMap().entries.forEach((e) {
      final index = e.key;
      final item = e.value;

      // 扇形的角度
      final startAngleRad = (index * angle - 90) * math.pi / 180;
      final sweepAngleRad = angle * math.pi / 180;
      final center = Offset(size.width / 2, size.height / 2);

      // 扇形填充颜色
      Paint paintFill = Paint()
        ..color = item.titleBackgroundColor ?? Colors.orange
        ..style = PaintingStyle.fill;

      // 中心区域的小扇形
      Paint paintCenter = Paint()
        ..color = item.amountBackgroundColor ?? Colors.yellow
        ..style = PaintingStyle.fill;

      // 扇形边框
      Paint paintStroke = Paint()
        ..color = Colors.orangeAccent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6;

      // 扇形的边界矩形
      Rect rect = Rect.fromCircle(
        center: center,
        radius: size.width / 2,
      );

      Rect rectCenter = Rect.fromCircle(
        center: center,
        radius: size.width / 3,
      );

      // 绘制扇形填充和边框
      canvas.drawArc(rect, startAngleRad, sweepAngleRad, true, paintFill);
      canvas.drawArc(rectCenter, startAngleRad, sweepAngleRad, true, paintCenter);
      canvas.drawArc(rect, startAngleRad, sweepAngleRad, true, paintStroke);

      if (item.titleText != null) {
        _drawText(
          canvas: canvas,
          text: item.titleText!,
          center: center,
          radius: size.width / 2 - size.width * 20 / 200,
          angle: startAngleRad + sweepAngleRad / 2,
          color: item.titleTextColor, fontSize: 14
        );
      }

      if (item.amountText != null) {
        _drawText(
          canvas: canvas,
          text: item.amountText!,
          center: center,
          radius: size.width / 3 - size.width * 20 / 200,
          angle: startAngleRad + sweepAngleRad / 2,
          color: item.amountTextColor,
          fontSize: 14
        );
      }
    });
  }

  //绘制文本方法 radius 越大离中心点越远
  void _drawText({
    required Canvas canvas,
    required String text,
    required Offset center,
    required double radius,
    required double angle,
    Color? color,
    double? fontSize,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    final textCenter = Offset(
      center.dx + radius * math.cos(angle),
      center.dy + radius * math.sin(angle),
    );

    canvas.save();
    canvas.translate(textCenter.dx, textCenter.dy);
    canvas.rotate(angle + math.pi / 2);

    textPainter.paint(
      canvas,
      Offset(-textPainter.width / 2, -textPainter.height / 2),
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MySectorItem {
  const MySectorItem({
    this.titleText,
    this.amountText,
    this.titleBackgroundColor = Colors.white,
    this.amountBackgroundColor = Colors.white,
    this.titleTextColor = Colors.black,
    this.amountTextColor = Colors.black,
  });

  final String? titleText;
  final String? amountText;
  final Color? titleBackgroundColor;
  final Color? amountBackgroundColor;
  final Color? titleTextColor;
  final Color? amountTextColor;
}
