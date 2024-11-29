import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAlert extends StatefulWidget {
  static final globalKey = GlobalKey<_MyAlertState>();

  const MyAlert({
    super.key,
    this.child,
  });

  final Widget? child;

  static void showLoading() {
    globalKey.currentState?.showLoading();
  }

  static void hideLoading() {
    globalKey.currentState?.hideLoading();
  }

  static void showBlock() {
    globalKey.currentState?.showBlock();
  }

  static void hideBlock() {
    globalKey.currentState?.hideBlock();
  }

  static void showSnack({Widget? child}) {
    globalKey.currentState?.showSnack(child: child);
  }

  @override
  State<MyAlert> createState() => _MyAlertState();
}

class _MyAlertState extends State<MyAlert> with TickerProviderStateMixin {
  bool _isShowLoading = false;
  bool _isShowBlock = false;

  Widget _snack = const Text('Please enter your widget', style: TextStyle(fontSize: 14, color: Colors.white));

  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _positionAnimation;

  @override
  void initState() {
    super.initState();

    // 初始化 AnimationController
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    // 定义透明度动画，从 0 到 1 再到 0
    _opacityAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeOut)), weight: 1),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 4),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0).chain(CurveTween(curve: Curves.easeOut)), weight: 1),
    ]).animate(_animationController);

    // 定义位置动画，从 0 到 100 再返回 0
    _positionAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: kToolbarHeight).chain(CurveTween(curve: Curves.easeOut)), weight: 1),
      TweenSequenceItem(tween: ConstantTween(kToolbarHeight), weight: 4),
      TweenSequenceItem(tween: Tween(begin: kToolbarHeight, end: 0.0).chain(CurveTween(curve: Curves.easeOut)), weight: 1),
    ]).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose(); // 释放资源
    super.dispose();
  }

  void showLoading() {
    setState(() {
      _isShowLoading = true;
    });
  }

  void hideLoading() {
    setState(() {
      _isShowLoading = false;
    });
  }

  void showBlock() {
    setState(() {
      _isShowBlock = true;
    });
  }

  void hideBlock() {
    setState(() {
      _isShowBlock = false;
    });
  }

  void showSnack({Widget? child}) {
    if (child != null) {
      setState(() {
        _snack = child;
        _animationController.reset();
        _animationController.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loadingBox = Center(
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CupertinoActivityIndicator(color: Colors.white, radius: 12),
          ),
        ),
      ),
    );

    final loading = _isShowLoading
        ? Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.3),
            child: loadingBox,
          )
        : const SizedBox();

    final block = _isShowBlock ? Container(color: Colors.black.withOpacity(0.1)) : const SizedBox();

    final screenHeight = MediaQuery.of(context).size.height;
    final keyboardHeight = MediaQueryData.fromView(View.of(context)).viewInsets.bottom;
    final bottomHeight = MediaQuery.of(context).viewInsets.bottom;
    final snackbarHeight = screenHeight - kToolbarHeight - kToolbarHeight;

    final snackBar = AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Visibility(
          visible: _opacityAnimation.value != 0,
          child: Opacity(
            opacity: _opacityAnimation.value, // 控制透明度
            child: Transform.translate(
              offset: Offset(0, _positionAnimation.value), // 控制位置
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: snackbarHeight),
                  child: IntrinsicHeight(
                    child: Center(
                      child: Material(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        color: Colors.black87,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          child: IntrinsicWidth(child: _snack),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    return Stack(
      children: [
        widget.child ?? const SizedBox(),
        loading,
        block,
        snackBar,
      ],
    );
  }
}
