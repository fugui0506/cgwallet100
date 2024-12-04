import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class MyHtml extends StatelessWidget {
  const MyHtml({
    super.key,
    required this.data,
    this.alignment,
    this.textAlign,
    this.maxLines,
    this.padding,
    this.margin,
    this.lineHeight,
    this.textOverflow,
    this.height,
  });

  final String data;
  final Alignment? alignment;
  final TextAlign? textAlign;
  final int? maxLines;
  final HtmlPaddings? padding;
  final Margins? margin;
  final LineHeight? lineHeight;
  final TextOverflow? textOverflow;
  final Height? height;

  @override
  Widget build(BuildContext context) {
    final richText = data.replaceAll('\n', '<br>');
    return Html(data: richText, style: {
      "html": Style(
        padding: HtmlPaddings.zero,
        margin: Margins.zero,
      ),
      "body": Style(
        padding: padding ?? HtmlPaddings.zero,
        margin: margin ?? Margins.zero,
        alignment: alignment,
        textAlign: textAlign,
        maxLines: maxLines,
        textOverflow: textOverflow,
        lineHeight: lineHeight,
        height: height,
      ),
    });
  }
}