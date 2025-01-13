import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyVideoPlayer extends StatefulWidget {
  const MyVideoPlayer({
    super.key,
    this.videoUrl,
    this.file,
    this.loading,
  });

  final String? videoUrl;
  final File? file;
  final Widget? loading;

  @override
  State<MyVideoPlayer> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  bool _isShowLoading = true;

  final _customControls = MaterialControls();

  Future<void> initPlayer() async {
    if (widget.videoUrl == null && widget.file == null) {
      throw('视频地址和视频文件不能同时为空');
    } else {
      if (widget.file != null) {
        _videoPlayerController = VideoPlayerController.file(widget.file!);
      } else {
        _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl!));
      }
    }
    
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: false,
      customControls: _customControls,
    );

    try {
      await _videoPlayerController.initialize();
      setState(() {
        _isShowLoading = false;
      });

      log('视频初始化成功');
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    initPlayer();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MyVideoPlayer oldWidget) {
    // 页面刷新的时候
    // 先暂停旧的视频，然后重新初始化
    _videoPlayerController.pause();

    _videoPlayerController.dispose().then((value) {
      _chewieController.dispose();
      initPlayer();
      setState(() {
        _isShowLoading = true;
      });
    });

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // 视频的封面
    final imageBox = Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
    );

    // 视频区的遮罩，主要是遮住封面图
    final mark = Container(
      color: Colors.black.withValues(alpha: 0.7),
      width: double.infinity,
      height: double.infinity,
    );

    // 加载中：精彩即将开始。。。
    final loadingContent = widget.loading ?? const SizedBox();

    final loadingBox = Stack(children: [
      imageBox,
      mark,
      loadingContent,
    ]);

    final size = MediaQuery.of(context).size.width - 40 - 32;

    // 加载中的组成方式：
    // 封面图放最底下
    // 遮罩罩住封面图
    // 加载动画
    // 最后把加载中放到顶层
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: size, maxHeight: size), 
      child: _isShowLoading
        ? loadingBox
        : Container(
            color: Colors.black,
            child: Chewie(controller: _chewieController),
          )
    );
  }
}
