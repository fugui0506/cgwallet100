import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MySlidable extends StatefulWidget {
  const MySlidable({
    super.key,
    this.onPressed,
    required this.actions,
    this.slidableController,
    this.groupTag,
    required this.child,
    this.isFloatRight = true
  });

  final void Function()? onPressed;
  final List<Widget> actions;
  final SlidableController? slidableController;
  final Object? groupTag;
  final Widget child;
  final bool isFloatRight;

  @override
  State<MySlidable> createState() => _MySlidableState();
}

class _MySlidableState extends State<MySlidable> with TickerProviderStateMixin {
  late SlidableController _controller;
  late double _animation = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = widget.slidableController ?? SlidableController(this);
    _controller.animation.addListener(_animationListener);
  }

  @override
  void dispose() {
    _controller.animation.removeListener(_animationListener);
    _controller.dispose();
    super.dispose();
  }

  void _animationListener() {
    setState(() {
      _animation = _controller.animation.value;
    });
  }

  void closeSlidable() async {
    await _controller.close();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_animation > 0.0) {
          closeSlidable();
        }
        widget.onPressed?.call();
      },
      child: Slidable(
        groupTag: widget.groupTag,
        controller: _controller,
        startActionPane: widget.isFloatRight ? null : ActionPane(
          motion: const ScrollMotion(),
          children: widget.actions,
        ),
        endActionPane: widget.isFloatRight ? ActionPane(
          motion: const ScrollMotion(),
          children: widget.actions,
        ) : null,
        child: widget.child,
      ),
    );
  }
}
