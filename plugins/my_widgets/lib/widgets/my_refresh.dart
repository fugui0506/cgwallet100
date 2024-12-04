import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyRefreshView extends StatelessWidget {
  const MyRefreshView({
    super.key,
    required this.controller,
    this.onRefresh,
    this.onLoading,
    required this.children,
    this.scrollController,
    this.padding,
    this.header,
    this.footer,
  });

  final RefreshController controller;
  final void Function()? onRefresh;
  final void Function()? onLoading;
  final List<Widget> children;
  final ScrollController? scrollController;
  final EdgeInsetsGeometry? padding;
  final Widget? header;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: onRefresh == null ? false : true,
      enablePullUp: onLoading == null ? false : true,
      header: onRefresh == null ? null : header,
      footer: onLoading == null ? null : footer,
      controller: controller,
      onRefresh: onRefresh,
      onLoading: onLoading,
      child: ListView(
        controller: scrollController,
        padding: padding,
        children: children,
      ),
    );
  }
}
