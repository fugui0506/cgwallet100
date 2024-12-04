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
  });

  final List<Widget> children;
  final void Function(int index) onChanged;
  final Duration timePageChange;
  final bool isAutoPlay;
  final double height;

  @override
  State<MyCarousel> createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  final PageController _pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initPageIndex();
    _autoToNextPage();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _initPageIndex() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.jumpToPage(widget.children.length);
    });
  }

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
    final repeatedChildren = [...widget.children, ...widget.children, ...widget.children];

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
            } else if (index == repeatedChildren.length - 1) {
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
        child: PageView.builder(
          controller: _pageController,
          itemCount: repeatedChildren.length,
          onPageChanged: (index) {
            widget.onChanged(index % totalLength);
          },
          itemBuilder: (context, index) {
            return repeatedChildren[index % totalLength];
          },
        ),
      ),
    );
  }
}