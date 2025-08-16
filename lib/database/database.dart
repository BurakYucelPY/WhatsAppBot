import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/kisi.dart';
import '../models/mesaj_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'whatsapp_bot.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE kisiler(
        id TEXT PRIMARY KEY,
        isim TEXT NOT NULL,
        soyisim TEXT NOT NULL,
        telefon TEXT NOT NULL,
        eposta TEXT,
        sirket TEXT,
        ulkeKodu TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE mesajlar(
        id TEXT PRIMARY KEY,
        alici TEXT NOT NULL,
        tarih TEXT NOT NULL,
        saat TEXT NOT NULL,
        mesaj TEXT NOT NULL,
        olusturmaTarihi TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertKisi(Kisi kisi) async {
    final db = await database;
    return await db.insert(
      'kisiler',
      {
        'id': kisi.id,
        'isim': kisi.isim,
        'soyisim': kisi.soyisim,
        'telefon': kisi.telefon,
        'eposta': kisi.eposta,
        'sirket': kisi.sirket,
        'ulkeKodu': kisi.ulkeKodu,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Kisi>> getKisiler() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('kisiler');

    return List.generate(maps.length, (i) {
      return Kisi(
        id: maps[i]['id'],
        isim: maps[i]['isim'],
        soyisim: maps[i]['soyisim'],
        telefon: maps[i]['telefon'],
        eposta: maps[i]['eposta'] ?? '',
        sirket: maps[i]['sirket'] ?? '',
        ulkeKodu: maps[i]['ulkeKodu'],
      );
    });
  }

  Future<int> deleteKisi(String id) async {
    final db = await database;
    return await db.delete(
      'kisiler',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllKisiler() async {
    final db = await database;
    return await db.delete('kisiler');
  }

  Future<int> insertMesaj(PlanlananMesaj mesaj) async {
    final db = await database;
    return await db.insert(
      'mesajlar',
      {
        'id': mesaj.id,
        'alici': mesaj.alici,
        'tarih': mesaj.tarih.toIso8601String(),
        'saat': mesaj.saat,
        'mesaj': mesaj.mesaj,
        'olusturmaTarihi': mesaj.olusturmaTarihi.toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<PlanlananMesaj>> getMesajlar() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('mesajlar');

    return List.generate(maps.length, (i) {
      return PlanlananMesaj(
        id: maps[i]['id'],
        alici: maps[i]['alici'],
        tarih: DateTime.parse(maps[i]['tarih']),
        saat: maps[i]['saat'],
        mesaj: maps[i]['mesaj'],
        olusturmaTarihi: DateTime.parse(maps[i]['olusturmaTarihi']),
      );
    });
  }

  Future<int> deleteMesaj(String id) async {
    final db = await database;
    return await db.delete(
      'mesajlar',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllMesajlar() async {
    final db = await database;
    return await db.delete('mesajlar');
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
