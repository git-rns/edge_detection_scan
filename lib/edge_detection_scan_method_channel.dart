import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'edge_detection_scan_platform_interface.dart';

/// An implementation of [IosDocumentScannerPlatform] that uses method channels.
class MethodChannelEdgeDetectionScan extends EdgeDetectionScanPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('document_scanner');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }

  @override
  Future<List<String>> scanDocument() async {
    final version = await methodChannel.invokeMethod<List<Object?>>(
      'scanDocument',
    );
    return (version ?? []).cast<String>();
  }
}
