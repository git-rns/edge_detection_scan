import 'package:flutter_test/flutter_test.dart';
import 'package:edge_detection_scan/edge_detection_scan.dart';
import 'package:edge_detection_scan/edge_detection_scan_platform_interface.dart';
import 'package:edge_detection_scan/edge_detection_scan_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockEdgeDetectionScanPlatform
    with MockPlatformInterfaceMixin
    implements EdgeDetectionScanPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final EdgeDetectionScanPlatform initialPlatform = EdgeDetectionScanPlatform.instance;

  test('$MethodChannelEdgeDetectionScan is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelEdgeDetectionScan>());
  });

  test('getPlatformVersion', () async {
    EdgeDetectionScan edgeDetectionScanPlugin = EdgeDetectionScan();
    MockEdgeDetectionScanPlatform fakePlatform = MockEdgeDetectionScanPlatform();
    EdgeDetectionScanPlatform.instance = fakePlatform;

    expect(await edgeDetectionScanPlugin.getPlatformVersion(), '42');
  });
}
