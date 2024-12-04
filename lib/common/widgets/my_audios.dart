import 'package:audioplayers/audioplayers.dart';

enum MyAudioPath {
  achievement('audios/achievement.mp3'), 
  click('audios/click.mp3'),
  coinDrop('audios/coin_drop.mp3'),
  dialog('audios/dialog.mp3'),
  news('audios/news.mp3'),
  scan('audios/scan.mp3'),
  setting('audios/setting.mp3');

  final String path;

  const MyAudioPath(this.path);
}

class MyAudio {
  // 私有构造函数
  MyAudio._privateConstructor();

  // 单例实例
  static final MyAudio _instance = MyAudio._privateConstructor();

  // 获取单例实例的方法
  static MyAudio get to => _instance;

  // 音频播放器实例（懒加载）
  late final AudioPlayer _audioPlayer = AudioPlayer();

  // 播放音频文件
  Future<void> play(MyAudioPath audioPath) async {
    // 检查播放器状态
    if (_audioPlayer.state == PlayerState.playing) {
      await _audioPlayer.stop();
    }
    
    // 播放音频
    await _audioPlayer.play(AssetSource(audioPath.path));
  }

  // 暂停音频播放
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  // 停止音频播放
  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  // 释放音频播放器资源
  void dispose() {
    _audioPlayer.dispose();
  }
}
