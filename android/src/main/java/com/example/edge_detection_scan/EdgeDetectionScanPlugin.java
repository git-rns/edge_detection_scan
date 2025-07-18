package com.example.edge_detection_scan;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodChannel;

public class EdgeDetectionScanPlugin implements FlutterPlugin, ActivityAware {
    private static final String channelName = "document_scanner";
    private MethodChannel channel;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), channelName);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        channel.setMethodCallHandler(new DocumentScanner(binding));
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        channel.setMethodCallHandler(new DocumentScanner(binding));
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
    }

    @Override
    public void onDetachedFromActivity() {
    }
}