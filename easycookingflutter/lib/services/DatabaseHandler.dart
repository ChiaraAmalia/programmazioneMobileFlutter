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
          "CREATE TABLE prodotti(nome_prodotto TEXT PRIMARY KEY NOT NULL)",
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

  Future<void> inserisciUno(Prodotto prodotto) async {

    final Database db = await initializeDB();
    await db.insert('prodotti', prodotto.toMap());

  }

  Future<List<Prodotto>> retriveProdotti() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('prodotti');
    return queryResult.map((e) => Prodotto.fromMap(e)).toList();
  }

  Future<void> cancellaProdotto(String nome_prodotto) async {
    final db = await initializeDB();
    await db.delete(
      'prodotti',
      where: "nome_prodotto = ?",
      whereArgs: [nome_prodotto],
    );
  }
}