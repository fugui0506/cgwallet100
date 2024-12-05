import 'dart:async';
import 'package:flutter/material.dart';

class MyCarousel extends StatefulWidget {
  const MyCarousel({
    super.key,
    required this.children,
    required this.onChanged,
    this.timePageChange = const Duration(milliseconds: 3000),
    this.isAutoPlay = false,
    this.height = 150.0,
    this.width = double.infinity,
  });

  final List<Widget> children;
  final void Function(int index) onChanged;
  final Duration timePageChange;
  final bool isAutoPlay;
  final double height;
  final double width;

  @override
  State<MyCarousel> createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  final PageController _pageController = PageController();
  Timer? _timer;
  late final List<Widget> _cachedPages;

  @override
  void initState() {
    super.initState();
    _cachedPages = [...widget.children, ...widget.children, ...widget.children];
    _initPageIndex();
    _autoToNextPage();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  /// 初始化页面索引
  void _initPageIndex() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.jumpToPage(widget.children.length);
    });
  }

  /// 自动播放逻辑
  void _autoToNextPage() {
    if (!widget.isAutoPlay) return;

    _cancelTimer();
    _timer = Timer.periodic(widget.timePageChange, (_) {
      if (mounted) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    final totalLength = widget.children.length;

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          final page = _pageController.page;
          if (page != null) {
            final index = page.round();
            if (index == 0) {
              Future.microtask(() {
                _pageController.jumpToPage(totalLength);
              });
            } else if (index == _cachedPages.length - 1) {
              Future.microtask(() {
                _pageController.jumpToPage(totalLength - 1);
              });
            }
          }
          _autoToNextPage();
        } else if (notification is ScrollStartNotification) {
          _cancelTimer();
        }
        return false;
      },
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: PageView.builder(
          controller: _pageController,
          itemCount: _cachedPages.length,
          onPageChanged: (index) {
            widget.onChanged(index % totalLength);
          },
          itemBuilder: (context, index) => _cachedPages[index],
        ),
      ),
    );
  }
}

class MyCarouselBar extends StatelessWidget{
  const MyCarouselBar({
    super.key,
    required this.length,
    required this.index,
    this.width,
    this.height,
    this.color,
    this.focusColor,
    this.radius = 4,
  });

  final int length;
  final int index;
  final double? width;
  final double? height;
  final double radius;
  final Color? color;
  final Color? focusColor;

  @override
  Widget build(BuildContext context) {
    final children = List<Widget>.generate(length, (i) {
      return Container(
        width: width ?? 8,
        height: height ?? 8,
        margin: EdgeInsets.only(right: i == length - 1 ? 0 : 4,),
        decoration: BoxDecoration(
          color: i == index ? focusColor ?? Colors.blue : color ?? Colors.grey,
          borderRadius: BorderRadius.circular(radius),
        ),
      );
    });

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: children),
    );
  }
}