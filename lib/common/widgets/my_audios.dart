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
  static final MyAudio _instance = MyAudio._internal();
  factory MyAudio() => _instance;
  MyAudio._internal();

  static Future<void> play(MyAudioPath audioPath) => _instance._play(audioPath);
  static Future<void> pause() => _instance._pause();
  static Future<void> stop() => _instance._stop();
  static void dispose() => _instance._dispose();

  // 音频播放器实例（懒加载）
  late final AudioPlayer _audioPlayer = AudioPlayer();

  // 播放音频文件
  Future<void> _play(MyAudioPath audioPath) async {
    // 检查播放器状态
    if (_audioPlayer.state == PlayerState.playing) {
      await _audioPlayer.stop();
    }
    await _audioPlayer.play(AssetSource(audioPath.path));
  }

  // 暂停音频播放
  Future<void> _pause() async {
    await _audioPlayer.pause();
  }

  // 停止音频播放
  Future<void> _stop() async {
    await _audioPlayer.stop();
  }

  // 释放音频播放器资源
  void _dispose() {
    _audioPlayer.dispose();
  }
}
