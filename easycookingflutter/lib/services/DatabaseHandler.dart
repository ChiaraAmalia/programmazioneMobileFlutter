import 'package:easycookingflutter/Model/Prodotto.dart';
import 'package:easycookingflutter/Model/RicettaInserimento.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'easyCooking2.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE prodotti(nome_prodotto TEXT PRIMARY KEY NOT NULL)",
        );
        await database.execute(
          "CREATE TABLE spesa(nome_prodotto TEXT PRIMARY KEY NOT NULL)",
        );
        await database.execute(
          "CREATE TABLE ricettetue(nome_ricetta TEXT PRIMARY KEY NOT NULL, ingredienti_ricetta TEXT NOT NULL, cookTime TEXT NOT NULL, prepTime TEXT NOT NULL, totalTime TEXT NOT NULL, fotoRicetta BLOB, porzioni TEXT NOT NULL, preparazione TEXT NOT NULL)",
        );
      },
      version: 1,
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

  Future<void> inserisciUnoSpesa(Prodotto prodotto) async {

    final Database db = await initializeDB();
    await db.insert('spesa', prodotto.toMap());

  }

  Future<List<Prodotto>> retriveSpesa() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('spesa');
    return queryResult.map((e) => Prodotto.fromMap(e)).toList();
  }

  Future<void> cancellaProdottoSpesa(String nome_prodotto) async {
    final db = await initializeDB();
    await db.delete(
      'spesa',
      where: "nome_prodotto = ?",
      whereArgs: [nome_prodotto],
    );
  }

  Future<void> inserisciUnaRicetta(RicettaInserimento ricetta) async {

    final Database db = await initializeDB();
    await db.insert('ricettetue', ricetta.toMap());

  }

  Future<List<RicettaInserimento>> retriveRicetteTue() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('ricettetue');
    return queryResult.map((e) => RicettaInserimento.fromMap(e)).toList();
  }

  Future<void> cancellaRicettaTua(String nome_ricetta) async {
    final db = await initializeDB();
    await db.delete(
      'ricettetue',
      where: "nome_ricetta = ?",
      whereArgs: [nome_ricetta],
    );
  }
}