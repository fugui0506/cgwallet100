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

  final List<Widget> _snacks = [];
  final List<AnimationController> _animationControllers = [];

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
    if (child == null) return;

    final snackAnimationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    final opacityAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeOut)), weight: 1),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 4),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0).chain(CurveTween(curve: Curves.easeOut)), weight: 1),
    ]).animate(snackAnimationController);

    final positionAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: kToolbarHeight).chain(CurveTween(curve: Curves.easeOut)), weight: 1),
      TweenSequenceItem(tween: ConstantTween(kToolbarHeight), weight: 4),
      TweenSequenceItem(tween: Tween(begin: kToolbarHeight, end: 0.0).chain(CurveTween(curve: Curves.easeOut)), weight: 1),
    ]).animate(snackAnimationController);

    // 启动动画
    snackAnimationController.forward();

    // 添加动画状态监听器，动画完成后移除 Snackbar
    snackAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // 动画完成后移除对应的 Snackbar 和动画控制器
        setState(() {
          _snacks.removeAt(0);
          _animationControllers.removeAt(0);
        });
        snackAnimationController.dispose();
      }
    });

    setState(() {
      _snacks.add(
        _SnackBarWidget(
          snackAnimationController: snackAnimationController,
          opacityAnimation: opacityAnimation,
          positionAnimation: positionAnimation,
          child: child,
        ),
      );
      _animationControllers.add(snackAnimationController);
    });
  }

  @override
  Widget build(BuildContext context) {
    final loadingBox = Center(
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.3),
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
        color: Colors.black.withValues(alpha: 0.1),
        child: loadingBox,
      ) : const SizedBox();

    final block = _isShowBlock ? Container(color: Colors.black.withValues(alpha: 0.1)) : const SizedBox();

    return Stack(
      children: [
        widget.child ?? const SizedBox(),
        loading,
        block,
        ..._snacks,
      ],
    );
  }
}

class _SnackBarWidget extends StatelessWidget {
  final AnimationController snackAnimationController;
  final Animation<double> opacityAnimation;
  final Animation<double> positionAnimation;
  final Widget child;

  const _SnackBarWidget({
    required this.snackAnimationController,
    required this.opacityAnimation,
    required this.positionAnimation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final keyboardHeight = MediaQueryData.fromView(View.of(context)).viewInsets.bottom;
    // final bottomHeight = MediaQuery.of(context).viewInsets.bottom;
    final snackbarHeight = screenHeight - kToolbarHeight - kToolbarHeight;

    return AnimatedBuilder(
      animation: snackAnimationController,
      builder: (context, child) {
        return Visibility(
          visible: opacityAnimation.value != 0,
          child: Opacity(
            opacity: opacityAnimation.value,
            child: Transform.translate(
              offset: Offset(0, positionAnimation.value),
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
                          child: IntrinsicWidth(child: child),
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
      child: child,
    );
  }
}