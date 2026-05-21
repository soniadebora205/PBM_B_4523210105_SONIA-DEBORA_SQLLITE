import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('students.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, fileName);
    return sqlite3.open(path);
  }

  Future<void> createTables(Database db) async {
    db.execute('''
      CREATE TABLE IF NOT EXISTS students (
        id            INTEGER PRIMARY KEY AUTOINCREMENT,
        name          TEXT NOT NULL,
        ttl           TEXT,
        jenis_kelamin TEXT,
        alamat        TEXT,
        agama         TEXT,
        major         TEXT NOT NULL,
        no_hp         TEXT,
        email         TEXT,
        photo_path    TEXT
      )
    ''');
  }

  Future<void> insertStudent(Map<String, dynamic> s) async {
    final db = await database;
    db.execute('''
      INSERT INTO students
        (name, ttl, jenis_kelamin, alamat, agama, major, no_hp, email, photo_path)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    ''', [
      s['name'], s['ttl'], s['jenis_kelamin'], s['alamat'],
      s['agama'],  s['major'], s['no_hp'], s['email'], s['photo_path'],
    ]);
  }

  Future<List<Map<String, dynamic>>> getStudents() async {
    final db = await database;
    final result = db.select('SELECT * FROM students ORDER BY id DESC');
    return result.map((row) => {
      'id':            row['id'],
      'name':          row['name'],
      'ttl':           row['ttl'],
      'jenis_kelamin': row['jenis_kelamin'],
      'alamat':        row['alamat'],
      'agama':         row['agama'],
      'major':         row['major'],
      'no_hp':         row['no_hp'],
      'email':         row['email'],
      'photo_path':    row['photo_path'],
    }).toList();
  }

  Future<void> updateStudent(Map<String, dynamic> s) async {
    final db = await database;
    db.execute('''
      UPDATE students
      SET name=?, ttl=?, jenis_kelamin=?, alamat=?,
          agama=?, major=?, no_hp=?, email=?, photo_path=?
      WHERE id=?
    ''', [
      s['name'], s['ttl'], s['jenis_kelamin'], s['alamat'],
      s['agama'], s['major'], s['no_hp'], s['email'],
      s['photo_path'], s['id'],
    ]);
  }

  Future<void> deleteStudent(int id) async {
    final db = await database;
    db.execute('DELETE FROM students WHERE id = ?', [id]);
  }
}