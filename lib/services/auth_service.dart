import 'package:simpeg_mascitra_mobile/helpers/db_helper.dart';
import 'package:simpeg_mascitra_mobile/models/user_model.dart';
import 'package:sqflite/sqflite.dart';


class AuthService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> register(String email, String password) async {
    final db = await _dbHelper.database;

    return await db.insert(
      'users',
      {
        'email': email,
        'password': password,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<User?> login(String email, String password) async {
    final db = await _dbHelper.database;

    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      return User.fromJson(result.first);
    }
    return null;
  }
}
