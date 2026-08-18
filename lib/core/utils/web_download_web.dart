// Web implementation of asset download using dart:html.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/services.dart' show rootBundle;

Future<void> downloadAsset(
  String assetPath,
  String downloadName, {
  String mimeType = 'application/octet-stream',
}) async {
  final byteData = await rootBundle.load(assetPath);
  final bytes = byteData.buffer.asUint8List();
  final blob = html.Blob([bytes], mimeType);
  final url = html.Url.createObjectUrlFromBlob(blob);
  html.AnchorElement(href: url)
    ..setAttribute('download', downloadName)
    ..click();
  html.Url.revokeObjectUrl(url);
}
