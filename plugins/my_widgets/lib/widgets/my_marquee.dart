import 'package:flutter/material.dart';

class MyMarquee extends StatefulWidget {
  const MyMarquee({
    super.key,
    required this.contents,
    this.textStyle,
  });

  final List<String> contents;
  final TextStyle? textStyle;

  @override
  State<MyMarquee> createState() => _MyMarqueeState();
}

class _MyMarqueeState extends State<MyMarquee> {
  final ScrollController _scrollController = ScrollController();
  int _index = 0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void init() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients && mounted) {
        final maxScrollExtent = _scrollController.position.maxScrollExtent;
        final duration = Duration(seconds: ((maxScrollExtent * 4) / 360).round()); // Adjust duration based on speed

        _scrollController.animateTo(
          maxScrollExtent,
          duration: duration,
          curve: Curves.linear,
        ).then((_) {
          if (_scrollController.hasClients && mounted) {
            _scrollController.jumpTo(0.0);
            setState(() {
              _index = (_index + 1) % widget.contents.length;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    init();
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          child: Row(
            children: [
              SizedBox(width: constraints.maxWidth),
              Text(widget.contents[_index], maxLines: 1, style: widget.textStyle, textDirection: TextDirection.ltr),
              SizedBox(width: constraints.maxWidth),
            ],
          ),
        );
      },
    );
  }
}
