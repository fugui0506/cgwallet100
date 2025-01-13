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
    this.errorWidget,
    this.isAlive = true,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final bool isAlive;

  @override
  Widget build(BuildContext context) {
    final loading = Container(
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width, maxHeight: MediaQuery.of(context).size.height),
      color: Colors.grey,
      width: width,
      height: height,
      child:  const CupertinoActivityIndicator(),
    );
    final brokenWidget = Container(
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width, maxHeight: MediaQuery.of(context).size.height),
      color: Colors.grey,
      width: width,
      height: height,
      child: FittedBox(child: Padding(padding: EdgeInsets.all(8), child: Icon(Icons.broken_image, color: Colors.black.withValues(alpha: 0.3)))),
    );
    try {
      return _KeepAliveWrapper(isAlive: isAlive, child: RepaintBoundary(
        child: Image.network(imageUrl,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress != null) {
              return loadingWidget ?? loading;
            } else {
              return child;
            }
          },
          errorBuilder: (context, error, stackTrace) {
            return errorWidget ?? loadingWidget ?? brokenWidget;
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
      ));
    } catch (e) {
      return _KeepAliveWrapper(isAlive: isAlive, child: loadingWidget ?? brokenWidget);
    }
  }
}

class _KeepAliveWrapper extends StatefulWidget {
  final Widget child;
  final bool isAlive;

  const _KeepAliveWrapper({
    // super.key,
    required this.child,
    this.isAlive = true,
  });

  @override
  State<_KeepAliveWrapper> createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<_KeepAliveWrapper> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => widget.isAlive;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}

