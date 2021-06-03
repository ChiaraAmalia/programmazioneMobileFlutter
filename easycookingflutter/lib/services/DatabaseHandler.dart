import 'package:easycookingflutter/Prodotto.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'easyCooking.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE prodotti(id INTEGER PRIMARY KEY AUTOINCREMENT, nome_prodotto TEXT NOT NULL)",
        );
      },
      version: 2,
    );
  }

  Future<int> inserisciProdotto(List<Prodotto> prodotti) async {
    int result = 0;
    final Database db = await initializeDB();
    for(var prodotto in prodotti){
      result = await db.insert('prodotti', prodotto.toMap());
    }
    return result;
  }

  Future<List<Prodotto>> retriveProdotti() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('prodotti');
    return queryResult.map((e) => Prodotto.fromMap(e)).toList();
  }

  Future<void> cancellaProdotto(int id) async {
    final db = await initializeDB();
    await db.delete(
      'prodotti',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}