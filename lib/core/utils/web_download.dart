// Cross-platform entry point for triggering a file download. The real
// implementation is web-only (dart:html); other platforms get a no-op stub so
// the code compiles under `flutter test` (Dart VM).
import 'web_download_stub.dart'
    if (dart.library.html) 'web_download_web.dart' as impl;

/// Loads a bundled asset and triggers a browser download with [downloadName].
Future<void> downloadAsset(
  String assetPath,
  String downloadName, {
  String mimeType = 'application/octet-stream',
}) =>
    impl.downloadAsset(assetPath, downloadName, mimeType: mimeType);
