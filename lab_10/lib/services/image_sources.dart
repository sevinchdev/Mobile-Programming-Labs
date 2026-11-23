import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

/// An error whose message can be shown to the user as is.
class ImageSourceException implements Exception {
  ImageSourceException(this.message);
  final String message;
  @override
  String toString() => message;
}

class ImageSources {
  final _picker = ImagePicker();

  /// null means the user cancelled.
  Future<Uint8List?> fromCamera() async {
    final shot = await _picker.pickImage(source: ImageSource.camera, maxWidth: 1024);
    return shot == null ? null : await shot.readAsBytes();
  }

  Future<Uint8List?> fromGallery() async {
    final pic = await _picker.pickImage(source: ImageSource.gallery, maxWidth: 1024);
    return pic == null ? null : await pic.readAsBytes();
  }

  Future<Uint8List> fromUrl(String url) async {
    final uri = Uri.tryParse(url.trim());
    if (uri == null || !(uri.isScheme('http') || uri.isScheme('https')) || uri.host.isEmpty) {
      throw ImageSourceException('That is not a valid address. It must start with https://');
    }
    final http.Response response;
    try {
      response = await http.get(uri).timeout(const Duration(seconds: 15));
    } on TimeoutException {
      throw ImageSourceException('The download took too long. Try again or use another address.');
    } on SocketException {
      throw ImageSourceException('No network connection, or the server was not found.');
    } on http.ClientException {
      throw ImageSourceException('No network connection, or the server was not found.');
    }
    if (response.statusCode != 200) {
      throw ImageSourceException(
          'The server answered ${response.statusCode} instead of 200. Check the address.');
    }
    final type = (response.headers['content-type'] ?? '').toLowerCase();
    if (!type.startsWith('image/')) {
      throw ImageSourceException(
          'That address is not a picture (it returned "${type.isEmpty ? 'unknown' : type}"). '
          'Use a direct link to an image file.');
    }
    return response.bodyBytes;
  }
}