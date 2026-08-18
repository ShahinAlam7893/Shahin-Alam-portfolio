// Non-web stub. Downloading is only supported on the web build.
Future<void> downloadAsset(
  String assetPath,
  String downloadName, {
  String mimeType = 'application/octet-stream',
}) async {
  // No-op on non-web platforms.
}
