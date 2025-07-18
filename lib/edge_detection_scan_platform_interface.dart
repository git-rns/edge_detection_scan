import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'edge_detection_scan_method_channel.dart';

abstract class EdgeDetectionScanPlatform extends PlatformInterface {
  /// Constructs a EdgeDetectionScanPlatform.
  EdgeDetectionScanPlatform() : super(token: _token);

  static final Object _token = Object();

  static EdgeDetectionScanPlatform _instance = MethodChannelEdgeDetectionScan();

  /// The default instance of [EdgeDetectionScanPlatform] to use.
  ///
  /// Defaults to [MethodChannelEdgeDetectionScan].
  static EdgeDetectionScanPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EdgeDetectionScanPlatform] when
  /// they register themselves.
  static set instance(EdgeDetectionScanPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<List<String>> scanDocument() async {
    throw UnimplementedError('scanDocument() has not been implemented.');
  }
}
