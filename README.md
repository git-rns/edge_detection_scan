# edge_detection_scan

A cross-platform Flutter plugin that provides native document scanning with automatic edge detection, returning high-quality scanned image paths from both Android and iOS.

### ✅ Platform Support
- **Android**: Uses Google ML Kit with Camera & File Storage
- **iOS**: Uses `VNDocumentCameraViewController` via Apple VisionKit

> Ideal for OCR workflows, document digitization, and PDF generation without OpenCV dependencies.

---

## ✨ Features

- Native document scanning UI
- Automatic edge detection
- Returns image file path
- Lightweight and easy to use
- Fully extendable for OCR and PDF output

---

## 📦 Installation

Add the package in your `pubspec.yaml`:

```yaml
dependencies:
  edge_detection_scan:
    git:
      url: https://github.com/git-rns/edge_detection_scan.git
```

Replace the URL with your [pub.dev](https://pub.dev) link once published.

---

## 🛠 Platform Configuration

### 🔹 Android

#### 1. Required Permissions

Add these permissions to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
```

---

### 🔹 iOS

- Minimum deployment target: **iOS 14.0+**

#### 1. Info.plist Settings

In `ios/Runner/Info.plist`, add:

```xml
<key>NSCameraUsageDescription</key>
<string>This app requires camera access to scan documents.</string>
<key>NSPhotoLibraryAddUsageDescription</key>
<string>This app needs photo library access to save scanned documents.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs access to view saved scans in your gallery.</string>
```

#### 2. Podfile Target

Update your `ios/Podfile`:

```ruby
platform :ios, '14.0'
```

Then run:

```bash
cd ios && pod install
```

---

## 💻 Usage

```dart
import 'package:edge_detection_scan/edge_detection_scan.dart';

Future<void> scanDocument() async {
  final imagePath = await EdgeDetectionScan.scanDocument();
  if (imagePath != null) {
    print('Scanned image saved at: $imagePath');
  }
}
```

---

## 📸 Output

Returns a local file path (`String`) to the scanned image:

- Display with `Image.file(File(imagePath))`
- Pass to OCR or ML models
- Convert to PDF

---

## 🧪 Example

```dart
ElevatedButton(
  onPressed: () async {
    final result = await EdgeDetectionScan.scanDocument();
    if (result != null) {
      showDialog(
        context: context,
        builder: (_) => Image.file(File(result)),
      );
    }
  },
  child: Text("Scan Document"),
)
```

---

## 🧩 How It Works

- **Android**: Captures an image using the native camera and stores it using `FileProvider`. ML Kit can be integrated for auto-cropping.
- **iOS**: Uses Apple's VisionKit to present a full document scanning interface with built-in edge detection.

---

## 📃 License

MIT © RNS

---

## 💬 Feedback or Contributions?

We welcome your issues and PRs!  
👉 [GitHub Repository](https://github.com/git-rns/edge_detection_scan)
