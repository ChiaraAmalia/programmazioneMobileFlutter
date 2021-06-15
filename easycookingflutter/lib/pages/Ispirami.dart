import 'package:easycookingflutter/Model/ricetta.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/MyFlutterApp.dart';
import 'package:randomizer/randomizer.dart';
import 'package:mailto/mailto.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'RicetteTue.dart';
/*
Schermata che prende in maniera randomica una ricetta dalla raccolta di Firebase e la mostra all'utente
in cerca di ispirazione.
 */
class Ispirami extends StatefulWidget {
  Ispirami({Key? key}) : super(key: key);

  @override
  _IspiramiState createState() => _IspiramiState();
}

class _IspiramiState extends State<Ispirami> {
  List<Ricetta> ricettaList = [];
  @override
  void initState() {
    super.initState();
    DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("");
    dbRef.once().then((DataSnapshot dataSnapshot) {
      ricettaList.clear();
      var values = dataSnapshot.value;

      for (var val in values) {
        Ricetta ric = new Ricetta(
          val["cookTime"],
          val["descrizione"],
          val["image"],
          val["Ingredienti"],
          val["intolleranze"],
          val["nome"],
          val["porzioni"],
          val["preparazione"],
          val["prepTime"],
          val["quantita"],
          val["recipeCategory"],
          val["recipeCuisine"],
          val["totalTime"],
          val["unita"],
          val["vegano"],
        );
        ricettaList.add(ric);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Randomizer randomizer = Randomizer();
    /*
    Prendo un numero a random e lo passo come indice alla lista contenente le ricette in modo da visualizzare
    la ricetta che si trova nella posizione indicata dall'indice
     */
    var ind=randomizer.getrandomnumber(0,414);
    return Scaffold(
      appBar: AppBar(
        title: Text("Easy Cooking"),
        actions: <Widget>[
          IconButton(
            /*
              Icona che se cliccata porta ad un'altra schermata dove si possono leggere le info relative all'applicazione
               */
            icon: const Icon(MyFlutterApp.info_outline, color: Colors.white,),
            tooltip: 'Info',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Info'),
                    ),
                    body: SingleChildScrollView(
                      child:Column(
                          children:[
                            Align(
                              alignment: Alignment.center,
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text:'Come iniziare? \n',
                                  style: TextStyle(color: Colors.red, fontSize:24,),
                                  children: <InlineSpan>[
                                    WidgetSpan(
                                        child: SizedBox(
                                          child:  Image.asset(
                                            "assets/images/food.png",
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                    TextSpan(text:'Cerca Ricette:\n', style: TextStyle(color: Colors.red,fontSize: 24)),],),),),
                            Text('In questa prima sezione è possibile cercare le ricette secondo il nome, la categoria oppure la sua origine. Cliccando su \'Vedi Ricette\' verranno restituite tutte le ricette presenti nel database. All\'interno della ricetta verranno visualizzate tutte le informazioni utili alla preparazione del piatto selezionato, inoltre è possibile condividere la ricetta oppure salvarla così da poterne usufruire senza la connessione ad internet.\n'),
                            RichText(text:TextSpan(text:'Dispensa\n',  style: TextStyle(color: Colors.red,fontSize: 24))),
                            Text('Nella sezione Dispensa è possibile registrare gli alimenti presenti nella vostra dispensa:  cliccando su \'Aggiungi\', si aprirà una piccola form in cui è possibile aggiungere l\'ingrediente desiderato. Per eliminare un elemento è sufficiente scorrere lo stesso verso sinistra. Infine è possibile effettuare un ricerca delle ricette secondo gli elementi inseriti.\n'),
                            RichText(text:TextSpan(text:'Lista Spesa\n',style: TextStyle(color: Colors.red, fontSize: 24))),
                            Text('Consiste di un\'effettiva lista della spesa: se, una volta visionata una ricetta, l\'utente dovesse rendersi conto di non avere un ingrediente potrà andarlo ad aggiungere in questa area. Anche in questo caso, per eliminare un elemento sarà sufficiente scorrere lo stesso verso sinistra.\n'),
                            RichText(text:TextSpan(text:'Tue Ricette\n',  style: TextStyle(color: Colors.red,fontSize: 24))),
                            Text('\'Ricette Tue\' è una funzionalità disponibile solo per gli utenti che hanno effettuato la registrazione: permette di creare ricette personalizzate secondo i gusti e le idee dell\'utente\n'),
                            RichText(text:TextSpan(text:'Login\n',  style: TextStyle(color: Colors.red,fontSize: 24))),
                            Text('Questa sezione sarà visibile solo agli utenti che non hanno effettuato la registrazione. Permette di effettuare il login oppure di registrarsi.\n'),
                            RichText(text:TextSpan(text:'Offline\n',  style: TextStyle(color: Colors.red,fontSize: 24))),
                            Text('Possiamo accedere a questa sezione solo se l\'utente è registrato, semplicemente cliccando sul pulsante RicetteTue. Qui potremo visualizzare ed accedere alle ricette che abbiamo salvato in precedenza.\n'),
                            RichText(text:TextSpan(text:'Ispirami\n',  style: TextStyle(color: Colors.red,fontSize: 24))),
                            Text('Non sai cosa cucinare? Pur di non pensare accetteresti un piatto a base di frattaglie di cavallo? Questa è la funzione che fa per te. \'Ispierami\' genera per te una ricetta casuale dal nostro database, a tuo rischio e pericolo :)\n'),
                            RichText(text:TextSpan(text:'Contattaci\n',  style: TextStyle(color: Colors.red,fontSize: 24))),
                            Text('Se hai domande puoi inviarci una mail. Se invece sei interessato ad ulteriori ricette puoi trovarci su instagram, dove le nostre esperte sono pronte a deliziarti con fantastici piatti!\n'),

                          ]),
                    ),
                  );
                },
              ));
            },
          ),
        ],
      ),
      body: ricettaList.length == 0 ? Center(child:CircularProgressIndicator()): SingleChildScrollView(
        child: Column(
            children: [
              ElevatedButton(
                /*
                Bottone che se premuto genera un nuovo indice, in modo da visulizzare un'altra ricetta
                 */
                onPressed: () {
                  setState(() {
                    ind = randomizer.getrandomnumber(0, 414);
                  });
                },
                child: const Text('Ispirami!'),
              ),
              //foto con titolo
              Container(
                  child: Column(
                    children: [
                      RaisedButton(
                        /*
                        Bottone che se cliccato permette la condivisione
                         */
                        child: Text('condividi'),
                        onPressed: () async{
                          share(context, ricettaList[ind]);
                        },
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints.expand(height: 210.0),
                        child: Image.network(
                          "https://firebasestorage.googleapis.com/v0/b/gino-49a3d.appspot.com/o/images%2F" +
                              ricettaList[ind].image +
                              "?alt=media&token=323e6eb7-b6e6-4b59-9ce8-f8936cf3cd29",
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(child:CircularProgressIndicator());
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              "assets/images/coltforc.png",
                              fit: BoxFit.cover,
                            ); //do something
                          },
                        ),
                      ),

                      Align(
                        alignment: Alignment.center,
                        child:
                        Padding(
                          padding: EdgeInsets.all(8),
                          child:Text(
                            ricettaList[ind].nome,
                            style: TextStyle(color: Colors.red, fontSize: 22,),maxLines: 5,textAlign: TextAlign.center,),
                      ),),

                      FittedBox(
                        fit: BoxFit.fitWidth, //tabella con tempi
                        child: DataTable(
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text(
                                'Preparazione:',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Cottura:',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Totale:',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ],
                          rows: <DataRow>[
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text(ricettaList[ind].prepTime)),
                                DataCell(Text(ricettaList[ind].cookTime)),
                                DataCell(Text(ricettaList[ind].totalTime)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth, //tabella con tempi
                        child: DataTable(
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text(
                                'Categoria:',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Origine:',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ],
                          rows: <DataRow>[
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text(ricettaList[ind].recipeCategory)),
                                DataCell(Text(ricettaList[ind].recipeCuisine)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth, //tabella con tempi
                        child: DataTable(
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text(
                                'Intolleranze:',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Vegano:',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),

                          ],
                          rows: <DataRow>[
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text(leggiLista(ricettaList[ind].intolleranze))),
                                DataCell(Text(leggiBooleano(ricettaList[ind].vegano))),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text("Ingredienti:", style: TextStyle(color: Colors.red,
                          fontSize: 24,
                          fontStyle: FontStyle.italic)),
                      Row(
                          children: [

                            Text(leggiLista(ricettaList[ind].ingredienti),),
                            SizedBox(width: 7,),
                            Text(leggiLista(ricettaList[ind].quantita)),
                            SizedBox(width: 7,),
                            Text(leggiLista(ricettaList[ind].unita)),

                          ]
                      ),


                      Text("Procedimento:", style: TextStyle(color: Colors.red,
                          fontSize: 24,
                          fontStyle: FontStyle.italic)),
                      Text(ricettaList[ind].preparazione),
                    ],
                  )
              ),
            ]),
      ),
    );
  }

  /*
  Metodo che trasforma una lista di oggetti in una stringa in modo da poterla
  visualizzare correttamente
   */
  String leggiLista(List<Object> lista) {
    String str = "";
    for (var val in lista) {
      str = str + val.toString() + '\n';
    }
    return str;
  }

  /*
  Metodo che trasforma un booleano in una striga che è "Si", se il booleano restituisce true,
  "No" se il booleano restituisce false.
   */
  String leggiBooleano(bool booleano) {
    String str = "No";
    if (booleano == true) {
      str = "Si";
    }
    return str;
  }

  /*
  Metodo che genera la stringa contenente il nome della ricetta e l'invito a scaricare l'applicazione
  per la condivisione
   */
  void share(BuildContext context, Ricetta ricetta) {

    final RenderObject? box = context.findRenderObject();
    final String text = "Scarica la app EasyCooking per provare ricette come ${ricetta.nome}";

    Share.share(text, subject: "EasyCooking - " + ricetta.nome);
  }
}