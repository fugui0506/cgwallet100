import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class MyTurntable extends StatefulWidget {
  const MyTurntable({
    super.key,
    required this.onSetReward,
    required this.items,
    required this.size,
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
  final double size;
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

  List<ui.Image?> _images = [];

  @override
  void initState() {
    super.initState();
    // 初始化 controller
    _animationController = AnimationController(vsync: this);

    // 初始化 animation
    _animationSpinner = Tween<double>(
      begin: 0,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));

    _images = List.generate(widget.items.length, (i) => null);

    _loadImages();
  }

  Future<void> _loadImages() async {
    for (int i = 0; i < widget.items.length; i++) {
      final image = await _getWidgetImage(widget.items[i].image);
      if (image != null) {
        setState(() {
          _images[i] = image;
        });
      }
    }
  }

  // 将 Image 转换为 ui.Image
  Future<ui.Image?> _getWidgetImage(Image? image) async {
    if (image == null) {
      return null;
    }
    final Completer<ui.Image> completer = Completer();

    image.image
      .resolve(const ImageConfiguration())
      .addListener(ImageStreamListener((ImageInfo info, bool synchronousCall) {
        completer.complete(info.image);
      }),
    );

    return completer.future;
  }


  @override
  void dispose() {
    _animationController.stop();
    _animationController.dispose();
    super.dispose();
  }

  void _startLightAnimation() {
    _lightTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        _lightIndex = widget.lights == null || widget.lights!.isEmpty
          ? 0
          : (_lightIndex + 1) % widget.lights!.length;
      });
    });
  }

  void _stopLightAnimation() {
    _lightTimer?.cancel();
    _lightTimer = null;
  }

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
    if (index == null || index > widget.items.length - 1) {
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

      await _startSpin(8, 7, 360 - angle, Curves.easeOutExpo);
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
    while (_index == null) {
      await _startSpin(1, 6, 0, Curves.linear);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      // Lights container
      Container(
        constraints: BoxConstraints(maxWidth: widget.size, maxHeight: widget.size),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(
            color: Colors.brown.withValues(alpha: 0.2),
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
          child: widget.lights?[_lightIndex] ?? const SizedBox(),
        ),
      ),

      // Turntable container
      Container(
        constraints: BoxConstraints(maxWidth: widget.size, maxHeight: widget.size),
        child: LayoutBuilder(builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxWidth,
            padding: EdgeInsets.all(constraints.maxWidth * 22 / 200),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(
                  color: Colors.deepOrange.withValues(alpha: 0.5),
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
                    : CustomPaint(size: Size(constraints.maxWidth , constraints.maxWidth), painter: MyCustomPainter(list: widget.items, images: _images)),
                ),
              ),
            ),
          );
        }),
      ),

      // Pointer button
      IconButton(
        constraints: BoxConstraints(maxWidth: widget.size * 80 / 200, maxHeight: widget.size * 80 / 200),
        onPressed: _handleGo,
        icon: widget.pointer ?? const SizedBox(),
      ),
    ]);
  }
}

class MyCustomPainter extends CustomPainter {
  final List<MySectorItem> list;
  final List<ui.Image?> images;

  MyCustomPainter({
    required this.list,
    required this.images,
  });

  final TextStyle _defaultTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final angle = 360 / list.length;
    list.asMap().entries.forEach((e) {
      final index = e.key;
      final item = e.value;
      final startAngleRad = (index * angle - 90) * math.pi / 180;
      final sweepAngleRad = angle * math.pi / 180;
      final center = Offset(size.width / 2, size.height / 2);

      _drawSector(
        canvas: canvas,
        center: center,
        radius: size.width / 2,
        startAngle: startAngleRad,
        sweepAngle: sweepAngleRad,
        backgroundColor: item.titleBackgroundColor,
      );

      _drawSector(
        canvas: canvas,
        center: center,
        radius: size.width / 3,
        startAngle: startAngleRad,
        sweepAngle: sweepAngleRad,
        backgroundColor: item.amountBackgroundColor,
        borderWidth: 1.6,
      );

      _drawText(
        canvas: canvas,
        size: size,
        radius: size.width / 2 - size.width * 20 / 200,
        angle: startAngleRad + sweepAngleRad / 2,
        text: item.titleText,
        style: _defaultTextStyle.copyWith(color: item.titleTextColor),
      );

      _drawText(
        canvas: canvas,
        size: size,
        radius: size.width / 3 - size.width * 20 / 200,
        angle: startAngleRad + sweepAngleRad / 2,
        text: item.amountText,
        style: _defaultTextStyle.copyWith(color: item.amountTextColor),
        image: images[index],
      );
    });
  }

  void _drawSector({
    required Canvas canvas,
    required Offset center,
    required double radius,
    required double startAngle,
    required double sweepAngle,
    Color? backgroundColor,
    double? borderWidth,
  }) {
    Paint paintFill = Paint()
      ..color = backgroundColor ?? Colors.orange
      ..style = PaintingStyle.fill;

    Paint paintStroke = Paint()
      ..color = Colors.orangeAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth ?? 1.6;

    Rect rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rect, startAngle, sweepAngle, true, paintFill);
    if (borderWidth != null) {
      canvas.drawArc(rect, startAngle, sweepAngle, true, paintStroke);
    }
  }

  void _drawText({
    required Canvas canvas,
    required Size size,
    required double radius,
    required double angle,
    String? text,
    ui.Image? image,
    required TextStyle style,
  }) {
    // 绘制图像
    if (image != null) {
      final iconSize = size.width * 30 / 200;
      final center = Offset(size.width / 2, size.height / 2);

      final rect = Rect.fromCenter(
        center: Offset(
          center.dx + radius * math.cos(angle),
          center.dy + radius * math.sin(angle),
        ),
        width: iconSize,
        height: iconSize,
      );

      // 在绘制图像前应用旋转，使其与扇形边缘对齐
      canvas.save();
      canvas.translate(
        rect.center.dx,
        rect.center.dy,
      );
      canvas.rotate(angle + math.pi / 2);
      canvas.translate(
        -rect.center.dx,
        -rect.center.dy,
      );

      // 绘制图像
      canvas.drawImageRect(
        image,
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        rect,
        Paint(),
      );
      canvas.restore();
    } else if (text != null) {
      final textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        textDirection: TextDirection.ltr,
      )..layout();

      final textCenter = Offset(
        size.width / 2 + radius * math.cos(angle),
        size.height / 2 + radius * math.sin(angle),
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
    this.image,
  });

  final String? titleText;
  final String? amountText;
  final Color? titleBackgroundColor;
  final Color? amountBackgroundColor;
  final Color? titleTextColor;
  final Color? amountTextColor;
  final Image? image;
}