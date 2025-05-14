import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class FileUploadHelper {
  static Future<http.MultipartFile?> prepareFileUpload(
      String fieldName, File? file) async {
    if (file == null) return null;

    // Determine content type based on file extension
    final extension = file.path.split('.').last.toLowerCase();
    final mimeType = _getMimeType(extension);

    return await http.MultipartFile.fromPath(fieldName, file.path,
        contentType: mimeType);
  }

  static MediaType _getMimeType(String extension) {
    switch (extension) {
      case 'pdf':
        return MediaType('application', 'pdf');
      case 'jpg':
      case 'jpeg':
        return MediaType('image', 'jpeg');
      case 'png':
        return MediaType('image', 'png');
      default:
        return MediaType('application', 'octet-stream');
    }
  }
}
