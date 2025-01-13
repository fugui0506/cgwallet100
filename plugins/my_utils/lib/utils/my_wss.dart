import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:web_socket_channel/io.dart';

class MyWss {
  MyWss({
    required this.urls,
    required this.isCanConnect,
    required this.heartbeatMessage,
    this.heartbeatSeconds = 10,
    this.headers = const {},
    this.maxRetryCount = 3,
    this.retrySeconds = 1,
    this.timeoutSeconds = 2,
    this.onMaxRetryOut,
    this.onMessageReceived,
  });

  // 传参
  final List<String> urls;
  final Map<String, dynamic> headers;
  final void Function(dynamic)? onMessageReceived;
  final int maxRetryCount;
  final int retrySeconds;
  final Future<bool> Function() isCanConnect;
  final void Function()? onMaxRetryOut;
  final dynamic heartbeatMessage;
  final int heartbeatSeconds;
  final int timeoutSeconds;

  // WebSocket 连接对象
  IOWebSocketChannel? _webSocketChannel;

  // 心跳定时器 和 发送心跳的时间
  Timer? _heartbeatTimer;

  // 延迟重连的定时器
  Timer? _retryTimer;

  // 连接状态
  // 是否主动断开用户主动断开连接
  // 如果是主动断开的，就不重连了
  bool _isClosedByUser = false;
  bool _isConnected = false;
  bool _isConnecting = false;

  // 当前的重连次数
  int _retryAttempts = 0;

  // index
  int _index = 0;

  // 连接过的 url 数量
  int _urlCount = 0;

  // ws 重置到初始化状态
  Future<void> connect() async {
    await close();
    _retryAttempts = 0;
    await _retryConnection();
  }

  Future<void> reset() async {
    await close();
    _retryAttempts = 0;
    _urlCount = 0;
    await _retryConnection();
  }

  /// WebSocket 连接方法
  Future<void> _connectWebSocket() async {
    if (_isConnected) {
      log("⚠️ wss: ${urls[_index]} 已经连接... ⚠️");
      return;
    }

    if (_isConnecting) {
      log("⚠️ wss: ${urls[_index]} 正在连接... ⚠️");
      return;
    }

    if (urls.isEmpty || urls[_index].isEmpty) {
      log("⚠️ wss 链接为空，无法链接... ⚠️");
      return;
    }

    if (!await isCanConnect()) {
      log("⚠️ ${urls[_index]} -> 当前状态不允许连接 ⚠️");
      return;
    }

    log("🔗 尝试连接 WebSocket: ${urls[_index]}");
    _isConnecting = true;

    try {
      _webSocketChannel = IOWebSocketChannel.connect(
        Uri.parse(urls[_index]),
        headers: headers,
        pingInterval: Duration(seconds: heartbeatSeconds),
        connectTimeout: Duration(seconds: timeoutSeconds),
        customClient: HttpClient()..badCertificateCallback = (cert, host, port) => true,
      );

      await _webSocketChannel?.ready;

      _webSocketChannel?.stream.listen(
        _onMessageReceived,
        onDone: _onConnectionDone,
        onError: _onConnectionError,
        cancelOnError: true,
      );

      _isConnected = true;
      _isClosedByUser = false;
      _isConnecting = false;
      _retryAttempts = 0;
      _urlCount = 0;
      _cancelTimer(_retryTimer); // 取消可能的重连定时器
      _sendHeartBeat();

      log('✅ WebSocket 连接成功: ${urls[_index]}');
    } catch (e) {
      log('❌ ${urls[_index]} 连接失败 -> : $e');
      _isConnecting = false;
      _isClosedByUser = false;
      await _retryConnection();
    }
  }

  void _cancelTimer(Timer? timer) {
    timer?.cancel();
    timer = null;
  }

  /// 处理接收到的消息
  void _onMessageReceived(message) {
    onMessageReceived?.call(message);
  }

  /// WebSocket 连接关闭时处理
  void _onConnectionDone() {
    log('❌❌❌❌❌ WebSocket: ${urls[_index]} 已经关闭 -- ${DateTime.now()}');
    if (!_isClosedByUser) connect();
  }

  /// WebSocket 连接错误时处理
  void _onConnectionError(error) {
    log('❌❌❌❌❌ WebSocket: ${urls[_index]} 连接错误 -- ${DateTime.now()}');
    log(error.toString());
    connect();
  }

  /// 重连机制
  Future<void> _retryConnection() async {
    if (_retryAttempts >= maxRetryCount) {
      log('🛑 ${urls[_index]} 达到最大重连次数');
      _cancelTimer(_retryTimer);

      if (_urlCount == urls.length - 1) {
        onMaxRetryOut?.call();
      } else {
        _index = (_index + 1) % urls.length;
        _urlCount++;
        _retryAttempts = 0;
        connect();
      }
      return;
    }

    _retryAttempts++;

    // _cancelTimer(_retryTimer);
    if (await isCanConnect()) {
      await _connectWebSocket();
    } else {
      log('💥💥 无法重连: ${urls[_index]}，条件不满足 💥💥');
    }
  }

  /// 发送心跳包
  void _sendHeartBeat() {
    _cancelTimer(_heartbeatTimer);
    if (!_isConnected) return;

    _heartbeatTimer = Timer.periodic(Duration(seconds: heartbeatSeconds), (timer) {
      if (_isConnected) {
        try {
          send(heartbeatMessage);
          log('💓 心跳包发送成功');
        } catch (e) {
          log('💔 心跳包发送失败: $e');
        }
      } else {
        log('💔 WebSocket 未连接，停止发送心跳');
        _cancelTimer(_heartbeatTimer);
      }
    });
  }

  /// 断开 WebSocket 连接
  Future<void> close() async {
    _isClosedByUser = true;
    _isConnected = false;
    _isConnecting = false;
    _cancelTimer(_retryTimer);
    _cancelTimer(_heartbeatTimer);

    try {
      await _webSocketChannel?.sink.close().timeout(Duration(seconds: timeoutSeconds), onTimeout: () {
        log('⏰ 关闭操作超时: ${urls[_index]}');
        return null;
      });
    } catch (e) {
      log('❌ WebSocket: ${urls[_index]} 关闭时发生错误: $e');
    } finally {
      _webSocketChannel = null;
    }
  }

  /// 发送消息
  void send(data) {
    if (_isConnected && _webSocketChannel != null) {
      try {
        _webSocketChannel?.sink.add(data);
      } catch (e) {
        log('>>>>> 😔 消息发送失败（ ${DateTime.now()} ) --> $e');
        _retryConnection();
      }
    } else {
      log('>>>>> �� WebSocket 未连接，无法发送消息');
      _retryConnection();
    }
  }
}