import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:web_socket_channel/io.dart';

class MyWss {
  MyWss({
    required this.url,
    required this.isCanConnect,
    required this.heartbeatMessage,
    this.heartbeatSeconds = 10,
    this.onMessageReceived,
    this.headers = const {},
    this.maxRetryCount = 3,
    this.retrySeconds = 1,
    this.onMaxRetryOut,
  });

  // 传参
  final String url;
  final Map<String, dynamic> headers;
  final void Function(dynamic)? onMessageReceived;
  final int maxRetryCount;
  final int retrySeconds;
  final Future<bool> Function() isCanConnect;
  final void Function()? onMaxRetryOut;
  final dynamic heartbeatMessage;
  final int heartbeatSeconds;

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
  bool isConnected = false;
  bool _isConnecting = false;

  // 当前的重连次数
  int _retryAttempts = 0;

  // ws 重置到初始化状态
  Future<void> connect() async {
    await close();
    _retryAttempts = 0;
    await _retryConnection();
  }

  /// WebSocket 连接方法
  Future<void> _connectWebSocket() async {
    if (isConnected) {
      log("⚠️ wss: $url 已经连接... ⚠️");
      return;
    }

    if (_isConnecting) {
      log("⚠️ wss: $url 正在链接... ⚠️");
      return;
    }

    if (url.isEmpty) {
      log("⚠️ wss 链接为空，无法链接... ⚠️");
      return;
    }

    if (!await isCanConnect()) {
      log("⚠️ $url -> 当前状态不允许连接 ⚠️");
      return;
    }

    log("🔗 尝试连接 WebSocket: $url");
    _isConnecting = true;

    try {
      _webSocketChannel = IOWebSocketChannel.connect(
        Uri.parse(url),
        headers: headers,
        pingInterval: const Duration(seconds: 5),
        connectTimeout: const Duration(seconds: 3),
        customClient: HttpClient()..badCertificateCallback = (cert, host, port) => true,
      );

      await _webSocketChannel?.ready;

      _webSocketChannel?.stream.listen(
        _onMessageReceived,
        onDone: _onConnectionDone,
        onError: _onConnectionError,
        cancelOnError: true,
      );

      isConnected = true;
      _isClosedByUser = false;
      _isConnecting = false;
      _retryAttempts = 0;
      _cancelTimer(_retryTimer); // 取消可能的重连定时器
      _sendHeartBeat();

      log('✅ WebSocket 连接成功: $url');
    } on SocketException catch (e) {
      log('❌ $url SocketException: $e');
      _isConnecting = false;
      _isClosedByUser = false;
      await _retryConnection();
    } on TimeoutException catch (e) {
      log('❌ $url TimeoutException: $e');
      _isConnecting = false;
      _isClosedByUser = false;
      await _retryConnection();
    } catch (e) {
      log('❌ $url 未知异常: $e');
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
    log('❌❌❌❌❌ WebSocket: $url 已经关闭 -- ${DateTime.now()}');
    if (!_isClosedByUser) connect();
  }

  /// WebSocket 连接错误时处理
  void _onConnectionError(error) {
    log('❌❌❌❌❌ WebSocket: $url 连接错误 -- ${DateTime.now()}');
    log(error.toString());
    connect();
  }

  /// 重连机制
  Future<void> _retryConnection() async {
    if (_retryAttempts >= maxRetryCount) {
      log('🛑 $url 达到最大重连次数');
      _cancelTimer(_retryTimer);
      onMaxRetryOut?.call();
      return;
    }

    _retryAttempts++;
    int delaySeconds = retrySeconds * (_retryAttempts - 1);
    log('🔄 尝试第 $_retryAttempts 次连接 $url，等待 $delaySeconds 秒');

    print('12131313123222222');

    print('131231');

    // _cancelTimer(_retryTimer);
    if (await isCanConnect()) {
      await _connectWebSocket();
    } else {
      log('💥💥 无法重连: $url，条件不满足 💥💥');
    }
  }

  /// 发送心跳包
  void _sendHeartBeat() {
    _cancelTimer(_heartbeatTimer);
    if (!isConnected) return;

    _heartbeatTimer = Timer.periodic(Duration(seconds: heartbeatSeconds), (timer) {
      if (isConnected) {
        try {
          send(heartbeatMessage);
          log('💓 心跳包发送成功: $heartbeatMessage');
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
    isConnected = false;
    _isConnecting = false;
    _cancelTimer(_retryTimer);
    _cancelTimer(_heartbeatTimer);

    try {
      await _webSocketChannel?.sink.close().timeout(Duration(seconds: 3), onTimeout: () {
        log('⏰ 关闭操作超时: $url');
        return null;
      });
    } catch (e) {
      log('❌ WebSocket: $url 关闭时发生错误: $e');
    } finally {
      _webSocketChannel = null;
    }
  }

  /// 发送消息
  void send(data) {
    if (isConnected && _webSocketChannel != null) {
      try {
        _webSocketChannel?.sink.add(data);
        // log('>>>>> 🆕 消息发送成功（ ${DateTime.now()} ) --> ${MyTools.decode(data)}');
      } catch (e) {
        log('>>>>> 😔 消息发送失败（ ${DateTime.now()} ) --> $e');
      }
    }
  }
}