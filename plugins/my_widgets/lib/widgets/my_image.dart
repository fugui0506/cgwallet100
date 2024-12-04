import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  const MyImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.loadingWidget,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? loadingWidget;

  @override
  Widget build(BuildContext context) {
    final loading = const CupertinoActivityIndicator();
    Icon brokenImage = Icon(Icons.broken_image, size: 64, color: Colors.black.withOpacity(0.2));
    return RepaintBoundary(
      child: Image.network(imageUrl, 
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress != null) {
            return loadingWidget ?? loading;
          } else {
            return child;
          }
        },
        errorBuilder: (context, error, stackTrace) {
          return loadingWidget ?? SizedBox(
            width: width,
            height: height,
            child: LayoutBuilder(builder: (context, container) {
              return SizedBox(
                width: container.maxWidth / 3,
                height: container.maxHeight / 3,
                child: FittedBox(child: brokenImage),
              );
            }),
          );
        },
        frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {      
          if (frame == null) {
            return loadingWidget ?? loading;
          } else {
            return child;
          }
        },
        fit: fit,
        width: width,
        height: height,
      ),
    );
  }
}

