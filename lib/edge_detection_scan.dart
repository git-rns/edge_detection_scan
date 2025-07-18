import 'dart:io';

import 'package:edge_detection_scan/android_doc_scanner.dart';

import 'edge_detection_scan_platform_interface.dart';

class EdgeDetectionScan {
  Future<String?> getPlatformVersion() {
    return EdgeDetectionScanPlatform.instance.getPlatformVersion();
  }

  Future<List<String>> scanDocument() async {
    if (Platform.isAndroid) {
      var doc = await DocumentScanner(
        options: DocumentScannerOptions(pageLimit: 10),
      ).scanDocument();
      return doc.images;
    }
    if (Platform.isIOS) {
      return EdgeDetectionScanPlatform.instance.scanDocument();
    }
    throw ("Scan Document is not supported in this version");
  }
}
