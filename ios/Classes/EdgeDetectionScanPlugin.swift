import Flutter
import UIKit
import VisionKit

public class EdgeDetectionScanPlugin: NSObject, FlutterPlugin,
    VNDocumentCameraViewControllerDelegate
{

    var flutterResult: FlutterResult?
    var viewController: UIViewController?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "document_scanner",
            binaryMessenger: registrar.messenger()
        )
        let instance = EdgeDetectionScanPlugin()

        // Safely get root view controller
        if let window = UIApplication.shared.delegate?.window {
            instance.viewController = window?.rootViewController
        } else {
            instance.viewController = UIApplication.shared.keyWindow?.rootViewController
        }

        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "scanDocument" {
            guard VNDocumentCameraViewController.isSupported else {
                result(
                    FlutterError(
                        code: "unsupported",
                        message: "Scanner not supported on this device",
                        details: nil
                    )
                )
                return
            }

            flutterResult = result
            let scannerVC = VNDocumentCameraViewController()
            scannerVC.delegate = self

            if let vc = viewController {
                vc.present(scannerVC, animated: true)
            } else {
                result(
                    FlutterError(
                        code: "no_view_controller", message: "No view controller found",
                        details: nil))
            }

        } else if call.method == "getPlatformVersion" {
            result("iOS " + UIDevice.current.systemVersion)

        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    public func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController)
    {
        controller.dismiss(animated: true, completion: nil)
        flutterResult?(nil)
    }

    public func documentCameraViewController(
        _ controller: VNDocumentCameraViewController,
        didFailWithError error: Error
    ) {
        controller.dismiss(animated: true, completion: nil)
        flutterResult?(
            FlutterError(
                code: "scan_failed",
                message: error.localizedDescription,
                details: nil
            )
        )
    }

    public func documentCameraViewController(
        _ controller: VNDocumentCameraViewController,
        didFinishWith scan: VNDocumentCameraScan
    ) {
        var paths: [String] = []
        let tempDir = NSTemporaryDirectory()

        for i in 0..<scan.pageCount {
            let image = scan.imageOfPage(at: i)
            guard let data = image.jpegData(compressionQuality: 0.8) else {
                print("⚠️ Failed to convert page \(i) to JPEG")
                continue
            }

            let filename = "scan_\(UUID().uuidString).jpeg"
            let fileURL = URL(fileURLWithPath: tempDir).appendingPathComponent(filename)

            do {
                try data.write(to: fileURL)
                paths.append(fileURL.path)
                print("✅ Saved page \(i) to: \(fileURL.path)")
            } catch {
                print("⚠️ Failed to save file \(i): \(error)")
                continue
            }
        }

        controller.dismiss(animated: true) {
            self.flutterResult?(paths)
        }
    }
}
