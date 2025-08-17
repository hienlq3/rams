import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_filex/open_filex.dart';

class FileSaver {
  /// Lưu file vào thư mục Downloads của máy
  static Future<String?> saveToDownloads(File file) async {
    try {
      // Xin quyền storage (chỉ cần cho Android < 10)
      if (Platform.isAndroid) {
        var status = await Permission.storage.request();
        if (!status.isGranted) {
          throw Exception("Permission denied");
        }
      }

      Directory? downloadsDir;
      if (Platform.isAndroid) {
        downloadsDir = Directory("/storage/emulated/0/Download");
      } else if (Platform.isIOS) {
        downloadsDir = await getApplicationDocumentsDirectory();
      }

      if (downloadsDir == null) {
        throw Exception("Không tìm thấy thư mục Download");
      }

      final newPath = "${downloadsDir.path}/${file.uri.pathSegments.last}";
      final newFile = await file.copy(newPath);

      return newFile.path;
    } catch (e) {
      if (kDebugMode) {
        print("❌ Lỗi khi lưu file: $e");
      }
      return null;
    }
  }

  /// Mở file sau khi tải về
  static Future<void> openFile(String path) async {
    await OpenFilex.open(path);
  }
}
