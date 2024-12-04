import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

enum MyAssetStyle {
  svg,
  png,
  jpg,
  gif,
  lottie,
}

class MyAssets extends StatelessWidget {
  const MyAssets({
    super.key,
    required this.name,
    required this.style,
    this.width,
    this.height,
    this.color,
    this.fit,
  });

  final String name;
  final MyAssetStyle style;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case MyAssetStyle.png:
        return Image.asset('assets/images/$name.png',
          fit: fit,
          width: width,
          height: height,
          color: color,
        );

      case MyAssetStyle.jpg:
        return Image.asset('assets/images/$name.jpg',
          fit: fit,
          width: width,
          height: height,
          color: color,
        );

      case MyAssetStyle.gif:
        return Image.asset('assets/images/$name.gif',
          fit: fit,
          width: width,
          height: height,
          color: color,
        );

      case MyAssetStyle.svg:
        return SvgPicture.asset('assets/svg/$name.svg',
          width: width,
          height: height,
          colorFilter: color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
        );

      default:
        return LottieBuilder.asset('assets/lottie/$name.zip',
          fit: fit ?? BoxFit.fill,
          width: width,
          height: height 
        );
    }
  }
}
