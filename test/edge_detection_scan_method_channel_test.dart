import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:edge_detection_scan/edge_detection_scan_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelEdgeDetectionScan platform = MethodChannelEdgeDetectionScan();
  const MethodChannel channel = MethodChannel('edge_detection_scan');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
