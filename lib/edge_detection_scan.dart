
import 'edge_detection_scan_platform_interface.dart';

class EdgeDetectionScan {
  Future<String?> getPlatformVersion() {
    return EdgeDetectionScanPlatform.instance.getPlatformVersion();
  }
}
