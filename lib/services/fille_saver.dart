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
        await checkAndRequestStoragePermission();
        final status = await Permission.storage.request();
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

  static Future<void> checkAndRequestStoragePermission() async {
    if (Platform.isAndroid) {
      // Android 11 (API 30) trở lên cần MANAGE_EXTERNAL_STORAGE
      if (Platform.operatingSystemVersion.contains("API 30") ||
          Platform.operatingSystemVersion.contains("API 31") ||
          Platform.operatingSystemVersion.contains("API 32") ||
          Platform.operatingSystemVersion.contains("API 33") ||
          Platform.operatingSystemVersion.contains("API 34")) {
        final status = await Permission.manageExternalStorage.status;
        if (!status.isGranted) {
          final result = await Permission.manageExternalStorage.request();
          if (!result.isGranted) {
            throw Exception("Permission denied: MANAGE_EXTERNAL_STORAGE");
          }
        }
      } else {
        // Android 10 trở xuống → dùng Permission.storage
        final status = await Permission.storage.status;
        if (!status.isGranted) {
          final result = await Permission.storage.request();
          if (!result.isGranted) {
            throw Exception("Permission denied: STORAGE");
          }
        }
      }
    }
  }
}
