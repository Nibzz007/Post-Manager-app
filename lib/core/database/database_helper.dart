import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'posts_db.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE posts(id INTEGER PRIMARY KEY, title TEXT, body TEXT)',
        );
        await _createFavoritesTable(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) await _createFavoritesTable(db);
      },
    );
  }

  Future<void> _createFavoritesTable(Database db) async {
    await db.execute('''
      CREATE TABLE favorites(
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        overview TEXT,
        poster_path TEXT,
        release_date TEXT,
        vote_average REAL
      )
    ''');
  }

  Future<void> savePosts(List<Map<String, dynamic>> maps) async {
    final db = await database;
    for (var map in maps) {
      await db.insert(
        'posts',
        map,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Map<String, dynamic>>> getCachedPosts() async {
    final db = await database;
    return await db.query('posts');
  }

  // --- Favorites (movies) ---
  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await database;
    return await db.query('favorites');
  }

  Future<void> addFavorite(Map<String, dynamic> map) async {
    final db = await database;
    await db.insert(
      'favorites',
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeFavorite(int movieId) async {
    final db = await database;
    await db.delete('favorites', where: 'id = ?', whereArgs: [movieId]);
  }

  Future<bool> isFavorite(int movieId) async {
    final db = await database;
    final r = await db.query('favorites', where: 'id = ?', whereArgs: [movieId]);
    return r.isNotEmpty;
  }
}
