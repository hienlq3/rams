import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/models/document_item_model.dart';
import 'package:flutter_application_1/repositories/document_local_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

@singleton
class FileDownloader {
  final Dio dio;
  final DocumentLocalRepository documentLocalRepository;
  final int maxConcurrentDownloads = 3;
  final List<_DownloadTask> _queue = [];
  int _activeDownloads = 0;
  List<DocumentItemModel> _documents = [];
  void Function(int documentId, double progress, {String? error})? _onProgress;

  // ✅ Inject Dio từ ngoài vào
  FileDownloader({required this.dio, required this.documentLocalRepository});

  /// Set documents và callback khi cần dùng
  void configure({
    required List<DocumentItemModel> documents,
    void Function(int documentId, double progress, {String? error})? onProgress,
  }) {
    _documents = documents;
    _onProgress = onProgress;
  }

  Future<void> startDownloads({bool copyToDownloads = false}) async {
    final dir = await getTemporaryDirectory();

    for (final document in _documents) {
      if (document.fileReference.isNotEmpty) {
        final filename = Uri.parse(document.fileReference).pathSegments.last;
        final sanitizedFileName =
            '${document.id}-${sanitizeFileName(filename)}';

        final filepath = "${dir.path}/$sanitizedFileName";
        _queue.add(
          _DownloadTask(
            url: document.fileReference,
            path: filepath,
            documentId: document.id ?? -1,
          ),
        );
      }
    }
    _processQueue(copyToDownloads: copyToDownloads);
  }

  void _processQueue({bool copyToDownloads = false}) {
    while (_activeDownloads < maxConcurrentDownloads && _queue.isNotEmpty) {
      final task = _queue.removeAt(0);
      _activeDownloads++;

      _downloadFile(task, copyToDownloads: copyToDownloads)
          .then((_) {
            if (kDebugMode) {
              print("✅ Completed: ${task.path} (${task.url})");
            }
          })
          .catchError((e) {
            if (kDebugMode) {
              print("❌ Failed: ${task.url} - $e");
            }
          })
          .whenComplete(() {
            _activeDownloads--;
            _processQueue();
          });
    }
  }

  Future<void> _downloadFile(
    _DownloadTask task, {
    bool copyToDownloads = false,
  }) async {
    final file = File(task.path);

    if (await file.exists()) {
      if (kDebugMode) {
        print("⚠️ Skipped (already exists): ${task.path}");
      }
      _updateDocumentPath(
        task.documentId,
        task.path,
        copyToDownloads: copyToDownloads,
      );
      return;
    }

    try {
      await dio.download(
        task.url,
        task.path,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final percent = (received / total * 100).toStringAsFixed(0);
            if (kDebugMode) {
              print("⬇️ ${task.url} – $percent%");
              _onProgress?.call(task.documentId, received / total);
            }
          } else {
            _onProgress?.call(task.documentId, -1.0);
          }
        },
      );
      _updateDocumentPath(
        task.documentId,
        task.path,
        copyToDownloads: copyToDownloads,
      );
    } catch (e) {
      _onProgress?.call(task.documentId, -1.0, error: e.toString());
    }
  }

  static String sanitizeFileName(String name) {
    return name.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
  }

  void _updateDocumentPath(
    int documentId,
    String path, {
    bool copyToDownloads = false,
  }) {
    final docIndex = _documents.indexWhere((d) => d.id == documentId);
    if (docIndex != -1) {
      _documents[docIndex] = _documents[docIndex].copyWith(localFilePath: path);
      documentLocalRepository.updateDocumentLocalPath(documentId, path).then((
        value,
      ) {
        _onProgress?.call(documentId, 1.0);
      });
      if (copyToDownloads) {
        FileDownloader.copyDocumentToDownload(documentId, path);
      }
      if (kDebugMode) {
        print("📍 Updated local path for document $documentId: $path");
      }
    } else {
      if (kDebugMode) {
        print("⚠️ Document with id $documentId not found.");
      }
    }
  }

  void prioritizeDownload(int documentId) {
    final index = _queue.indexWhere((t) => t.documentId == documentId);
    if (index != -1) {
      final task = _queue.removeAt(index);
      _queue.insert(0, task);
      if (kDebugMode) {
        print("🚨 Prioritized download for documentId $documentId");
      }
      _processQueue();
    } else {
      if (kDebugMode) {
        print("⚠️ Task not found in queue or already downloading: $documentId");
      }
    }
  }

  static Future<void> copyDocumentToDownload(
    int documentId,
    String localFilePath,
  ) async {
    try {
      final localFile = File(localFilePath);

      final downloadPath = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOAD,
      );

      final filename = getFileNameFromReference(localFilePath);

      if (filename == null) {
        throw 'Invalid file reference';
      }
      final sanitizedFileName = sanitizeFileName(filename);
      final filepath = "$downloadPath/$sanitizedFileName";

      await localFile.copy(filepath);

      // Mở file nếu muốn:
      await OpenFilex.open(filepath);
    } catch (e) {
      log("Error copying file: $e");
      rethrow;
    }
  }

  static String? getFileNameFromReference(String? fileReference) {
    if (fileReference == null || fileReference.trim().isEmpty) {
      return null; // or return a default like "unknown.txt"
    }

    final uri = Uri.tryParse(fileReference);
    if (uri == null || uri.pathSegments.isEmpty) {
      return null;
    }

    return uri.pathSegments.last;
  }
}

class _DownloadTask {
  final String url;
  final String path;
  final int documentId;

  _DownloadTask({
    required this.url,
    required this.path,
    required this.documentId,
  });
}
