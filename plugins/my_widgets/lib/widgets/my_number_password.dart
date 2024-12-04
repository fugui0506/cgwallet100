import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyNumberPasswordInput extends StatefulWidget {
  const MyNumberPasswordInput({
    super.key,
    this.title = '',
    this.titleTextStyle,
    this.foregroundColor,
    this.backgroundColor,
    required this.borderColor,
    this.focusColor,
    required this.length,
    this.spacing = 8.0,
    this.padding,
  });

  final String title;
  final TextStyle? titleTextStyle;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color borderColor;
  final Color? focusColor;
  final int length;
  final double spacing;
  final EdgeInsetsGeometry? padding;

  @override
  State<MyNumberPasswordInput> createState() => _MyNumberPasswordInputState();
}

class _MyNumberPasswordInputState extends State<MyNumberPasswordInput> with TickerProviderStateMixin {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<String> _text = [];

  late AnimationController _animationController;
  late Animation<double> _opacity;

  @override
  void initState() {
    _text = List.generate(widget.length, (item) => '');

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _opacity = Tween(begin: 1.0, end: 0.0).animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Widget _buildInputBox({
    required BuildContext context,
    required List<String> strList,
    required FocusNode focusNode,
    required int index,
    Animation<double>? opacity,
    double? width,
    double? height,
  }) {
    int i = 0;
    for (var element in strList) {
      if (element != '') {
        i++;
      }
    }

    final focus = Container(
      height: 20,
      width: 2,
      color: widget.focusColor,
    );

    final del = CircleAvatar(
      backgroundColor: widget.foregroundColor,
      radius: 5,
    );

    final card = Container(
      width: width,
      height: height,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        border: strList[index] == '' && i != index
          ? null
          : Border.all(color: widget.borderColor , width: 2),
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      // margin: index != strList.length - 1 ? EdgeInsets.only(right: widget.spacing) : null,
      child: i == index
        ? opacity == null ? focus : FadeTransition(alwaysIncludeSemantics: true, opacity: opacity, child: Center(child: focus))
        : strList[index].isEmpty? null : Center(child: del),
    );

    return GestureDetector(onTap: focusNode.requestFocus, child: card);
  }

  @override
  Widget build(BuildContext context) {
    List<String> stringToList(List<String> value) {
      var list = <String>[];
      for (int i = 0; i < widget.length; i++) {
        if (i < value.length) {
          list.add('*');
        } else {
          list.add('');
        }
      }
      return list;
    }

    final input = TextField(
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      controller: _textEditingController,
      focusNode: _focusNode,
      maxLength: widget.length,
      onChanged: (value) {
        setState(() {
          _text = stringToList(value.split(''));
        });
        if (value.length == widget.length) {
          Navigator.of(context).pop(value);
        }
      },
      autofocus: true,
    );

    final title = Text(widget.title, style: widget.titleTextStyle);

    return Container(
      padding: widget.padding ?? EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          title,
          SizedBox(height: 20, child: Opacity(opacity: 0, child: input)),
          LayoutBuilder(builder: (context, container) {
            final width = (container.maxWidth - widget.spacing * (widget.length - 1)) / widget.length;
            final children = _text.asMap().entries.map((e) => _buildInputBox(
              context: context,
              strList: _text,
              focusNode: _focusNode,
              index: e.key,
              opacity: _opacity,
              width: width,
              height: width * 1.06,
            )).toList();
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            );
          }),
        ],
      ),
    );
  }
}

