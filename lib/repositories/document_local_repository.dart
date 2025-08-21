import 'package:flutter_application_1/models/document_item_model.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

@singleton
class DocumentLocalRepository {
  static final DocumentLocalRepository _instance =
      DocumentLocalRepository._internal();
  factory DocumentLocalRepository() => _instance;
  DocumentLocalRepository._internal();

  Database? _db;

  /// Mở hoặc tạo database
  Future<Database> _openDB() async {
    if (_db != null) return _db!;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'rams.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE documents (
            document_name TEXT,
            job_id INTEGER,
            is_engineer_ack_required INTEGER NOT NULL DEFAULT 0,
            attach_type INTEGER,
            file_reference TEXT,
            source_rule_document_id INTEGER,
            applied_rule_id INTEGER,
            show_on_visit_status_list TEXT,
            engineer_read_status INTEGER,
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            tenant_id TEXT,
            created_date_time TEXT,
            updated_date_time TEXT,
            localFilePath TEXT,
            is_acknowledged INTEGER NOT NULL DEFAULT 0
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // Migration khi thêm cột mới
        if (oldVersion < 2) {
          await db.execute(
            'ALTER TABLE documents ADD COLUMN localFilePath TEXT',
          );
        }
      },
    );
    return _db!;
  }

  /// Lấy toàn bộ documents
  Future<List<DocumentItemModel>> loadDocuments() async {
    final db = await _openDB();
    final maps = await db.query('documents');
    return maps.map(DocumentItemModelDb.fromDbJson).toList();
  }

  /// Lưu documents xuống local DB
  Future<void> saveToLocal(List<DocumentItemModel> docs) async {
    final db = await _openDB();
    final batch = db.batch();
    for (final doc in docs) {
      batch.insert(
        'documents',
        doc.toDbJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  /// Cập nhật đường dẫn file local
  Future<void> updateDocumentLocalPath(int documentId, String path) async {
    final db = await _openDB();
    await db.update(
      'documents',
      {'localFilePath': path},
      where: 'id = ?',
      whereArgs: [documentId],
    );
  }

  /// Xoá toàn bộ dữ liệu (nếu cần)
  Future<void> clearDocuments() async {
    final db = await _openDB();
    await db.delete('documents');
  }

  /// Lấy document theo ID
  Future<DocumentItemModel?> loadDocumentById(int id) async {
    final db = await _openDB();
    final maps = await db.query(
      'documents',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return DocumentItemModelDb.fromDbJson(maps.first);
    }
    return null; // Không tìm thấy
  }

  Future<List<DocumentItemModel>> loadDocumentsByJobId(int jobId) async {
    final db = await _openDB();
    final maps = await db.query(
      'documents',
      where: 'job_id = ?',
      whereArgs: [jobId],
    );
    return maps.map(DocumentItemModelDb.fromDbJson).toList();
  }

  Future<void> updateDocument(DocumentItemModel doc) async {
    final db = await _openDB();
    await db.update(
      'documents',
      doc.toDbJson(), // chuyển model sang Map<String, dynamic>
      where: 'id = ?',
      whereArgs: [doc.id],
    );
  }

  Future<void> updateAcknowledgement(int documentId, bool acknowledged) async {
    final db = await _openDB();
    await db.update(
      'documents',
      {
        'is_acknowledged': acknowledged ? 1 : 0,
        'updated_date_time': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [documentId],
    );
  }
}
