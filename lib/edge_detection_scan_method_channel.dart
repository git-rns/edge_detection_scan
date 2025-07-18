import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'edge_detection_scan_platform_interface.dart';

/// An implementation of [EdgeDetectionScanPlatform] that uses method channels.
class MethodChannelEdgeDetectionScan extends EdgeDetectionScanPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('edge_detection_scan');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
