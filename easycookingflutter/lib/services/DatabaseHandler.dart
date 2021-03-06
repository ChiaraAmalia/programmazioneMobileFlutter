import 'package:easycookingflutter/Model/Prodotto.dart';
import 'package:easycookingflutter/Model/RicettaInserimento.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/*
Classe per la gestione del database, dove vengono create le tabelle e vengono
creati i metodi che con esse interagiscono
 */
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

  /*
  Metodo che aggiunge, con un singolo comando, diversi prodotti nella dispensa
   */
  Future<int> inserisciProdotto(List<Prodotto> prodotti) async {
    int result = 0;
    final Database db = await initializeDB();
    for(var prodotto in prodotti){
      result = await db.insert('prodotti', prodotto.toMap());
    }
    return result;
  }

  /*
  Metodo che aggiunge un solo prodotto nella dispensa
   */
  Future<void> inserisciUno(Prodotto prodotto) async {

    final Database db = await initializeDB();
    await db.insert('prodotti', prodotto.toMap());

  }

  /*
  Metodo che restituisce la lista dei prodotti presenti nella dispensa
   */
  Future<List<Prodotto>> retriveProdotti() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('prodotti');
    return queryResult.map((e) => Prodotto.fromMap(e)).toList();
  }

  /*
  Metodo che elimina un solo prodotto dalla dispensa
   */
  Future<void> cancellaProdotto(String nome_prodotto) async {
    final db = await initializeDB();
    await db.delete(
      'prodotti',
      where: "nome_prodotto = ?",
      whereArgs: [nome_prodotto],
    );
  }

  /*
  Metodo che aggiunge un solo prodotto alla lista della spesa
   */
  Future<void> inserisciUnoSpesa(Prodotto prodotto) async {

    final Database db = await initializeDB();
    await db.insert('spesa', prodotto.toMap());

  }

  /*
  Metodo che restituisce la lista dei prodotti presenti nella lista della spesa
   */
  Future<List<Prodotto>> retriveSpesa() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('spesa');
    return queryResult.map((e) => Prodotto.fromMap(e)).toList();
  }

  /*
  Metodo che elimina un solo prodotto dalla lista della spesa
   */
  Future<void> cancellaProdottoSpesa(String nome_prodotto) async {
    final db = await initializeDB();
    await db.delete(
      'spesa',
      where: "nome_prodotto = ?",
      whereArgs: [nome_prodotto],
    );
  }

  /*
  Metodo che aggiunge una sola ricetta al database contenente quelle personali
   */
  Future<void> inserisciUnaRicetta(RicettaInserimento ricetta) async {

    final Database db = await initializeDB();
    await db.insert('ricettetue', ricetta.toMap());

  }

  /*
  Metodo che restituisce la lista delle ricette presenti nel database di quelle personali
   */
  Future<List<RicettaInserimento>> retriveRicetteTue() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('ricettetue');
    return queryResult.map((e) => RicettaInserimento.fromMap(e)).toList();
  }

  /*
  Metodo che elimina una ricetta dalle ricette presenti nel database delle ricette personali
   */
  Future<void> cancellaRicettaTua(String nome_ricetta) async {
    final db = await initializeDB();
    await db.delete(
      'ricettetue',
      where: "nome_ricetta = ?",
      whereArgs: [nome_ricetta],
    );
  }
}