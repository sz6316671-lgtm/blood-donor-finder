import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'blood_donor.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {

      await db.execute('''
        CREATE TABLE users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          email TEXT UNIQUE,
          dept TEXT,
          bloodGroup TEXT,
          phone TEXT,
          password TEXT
        )
      ''');


      await db.execute('''
        CREATE TABLE requests (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          patientName TEXT,
          hospital TEXT,
          bloodGroup TEXT,
          phone TEXT,
          isUrgent INTEGER
        )
      ''');
    });
  }


  Future<int> registerUser(Map<String, dynamic> user) async {
    var dbClient = await db;
    return await dbClient.insert('users', user);
  }


  Future<Map<String, dynamic>?> loginCheck(String email, String password) async {
    var dbClient = await db;
    List<Map<String, dynamic>> res = await dbClient.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return res.isNotEmpty ? res.first : null;
  }




  Future<int> updateUserProfile(String email, String name, String phone, String dept) async {
    var dbClient = await db;
    return await dbClient.update(
      'users',
      {
        'name': name,
        'phone': phone,
        'dept': dept,
      },
      where: 'email = ?',
      whereArgs: [email],
    );
  }


  Future<int> updatePassword(String email, String newPassword) async {
    var dbClient = await db;
    return await dbClient.update(
      'users',
      {'password': newPassword},
      where: 'email = ?',
      whereArgs: [email],
    );
  }




  Future<int> insertRequest(Map<String, dynamic> data) async {
    var dbClient = await db;
    return await dbClient.insert('requests', data);
  }


  Future<List<Map<String, dynamic>>> getRequests() async {
    var dbClient = await db;
    return await dbClient.query('requests', orderBy: 'id DESC');
  }


  Future<List<Map<String, dynamic>>> searchDonors(String bloodGroup) async {
    var dbClient = await db;
    return await dbClient.query(
        'users',
        where: 'bloodGroup = ?',
        whereArgs: [bloodGroup]
    );
  }
}