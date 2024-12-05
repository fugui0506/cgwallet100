
import 'package:flutter/cupertino.dart';

class MyAlive extends StatefulWidget {
  final Widget child;
  final bool isAlive;

  const MyAlive({
    super.key,
    required this.child,
    this.isAlive = true,
  });

  @override
  State<MyAlive> createState() => MyAliveState();
}

class MyAliveState extends State<MyAlive> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => widget.isAlive;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}