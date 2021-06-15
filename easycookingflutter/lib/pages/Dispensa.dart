import 'package:easycookingflutter/Model/ricetta.dart';
import 'package:easycookingflutter/MyFlutterApp.dart';
import 'package:easycookingflutter/Model/Prodotto.dart';
import 'package:easycookingflutter/services/DatabaseHandler.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'RicetteDettaglio.dart';

/*
Schermata che mostra gli alimenti presenti in dispensa e al click sui relativi bottoni attiva
i diversi metodi
 */
class Dispensa extends StatefulWidget{
  Dispensa({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  _DispensaState createState() => _DispensaState();
}

class _DispensaState extends State<Dispensa> {

//DATABASE
  late DatabaseHandler handler;
  late List<Ricetta> ricettaList = [];
  late List<Prodotto> ingredientiFilter = [];
  late List<Ricetta> ricetteFilter = [];

  @override
  void initState() {
    super.initState();
    this.handler = DatabaseHandler();
    this.handler.initializeDB();

    /*
    Prende le ricette dal database presente su firebase e per effettuare la ricerca di quelle che contengono
    gli ingredienti presenti in dispensa
     */
    DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("");
    dbRef.once().then((DataSnapshot dataSnapshot) {
      ricettaList.clear();
      //var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;

      for (var val in values) {
        Ricetta ric = new Ricetta(
          val["cookTime"],
          val["descrizione"],
          val["image"],
          val["Ingredienti"],
          val["intolleranze"],
          // values[key][k]["Ingredienti"],
          // values[key][k]["unita"],
          // values[key][k]["quantita"],
          //values[key][k]["keywords"],
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
      //ricetteFilter = ricettaList;
      setState(() {
        //
      });
    });
  }
//DATABASE
  
  //ALERT DIALOG
  /*
  Apre un Alert Dialog mediante il quale è possibile aggiungere un prodotto in dispensa,
  al click su annulla, non si effettua l'inserimento,
  al click su aggiungi viene aggiunto il prodotto nel database in maniera tale che si possano salvare i dati in maniera persistente
   */
  TextEditingController _textFieldController = TextEditingController();
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Aggiungi in Dispensa'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Nome prodotto..."),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('Annulla'),
                onPressed: () {
                  setState(() {
                    _textFieldController.clear();
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('Aggiungi'),
                onPressed: () {
                  setState(() {
                    Prodotto prod = Prodotto(nome_prodotto: valueText);
                    this.handler.inserisciUno(prod);
                    //ingredientiFilter.add(prod);
                    _textFieldController.clear();
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }
  /*
  Apre un Alert Dialog mediante il quale è possibile, visionare ed aggiungere i prodotti che mancano in dispensa, per preparare una determinata
  ricetta, alla lista della spesa
  al click su Non aggiungere, non si effettua l'inserimento nella lista della spesa, e si prosegue visionando la ricetta selezionata
  al click su Aggiungi alla lista della spesa viene aggiunto il prodotto alla lista della spesa e si visualizza poi la ricetta selezionata
   */
  Future<void> _displaySpesaDialog(BuildContext context, List<String> mancanti, int index) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ti mancano:'),
            content: Text(
              leggiLista(mancanti)
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('Non aggiungere'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => RicetteDettaglio(),
                      settings: RouteSettings(
                        arguments: ricetteFilter[index],
                      ),));
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('Aggiungi alla\n lista della spesa'),
                onPressed: () {
                  setState(() {
                    for(var pr in mancanti){
                    Prodotto prod = Prodotto(nome_prodotto: pr);
                    this.handler.inserisciUnoSpesa(prod);}
                    //ingredientiFilter.add(prod);

                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => RicetteDettaglio(),
                      settings: RouteSettings(
                        arguments: ricetteFilter[index],
                      ),));
                  });
                },
              ),
            ],
          );
        });
  }
  
  late String valueText;
  //ALERT DIALOG

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:Center(
        child:Column(
        children:[
          Expanded(child: SizedBox(
        height:120.0,
        child: FutureBuilder(
        future: this.handler.retriveProdotti(),
        builder: (BuildContext context, AsyncSnapshot<List<Prodotto>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              /*
              Se il DataBase contiene prodotti, mostra una lista di quest'ultimi, con la possibilità di
              cancellarli scorrendo da destra a sinistra
              */
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(Icons.delete_forever),
                  ),
                  key: ValueKey<String>(snapshot.data![index].nome_prodotto),
                  onDismissed: (DismissDirection direction) async {
                    await this.handler.cancellaProdotto(snapshot.data![index].nome_prodotto);
                    setState(() {
                      snapshot.data!.remove(snapshot.data![index]);
                    });
                  },
                  child: Card(
                    child: ListTile(
                      contentPadding: EdgeInsets.all(8.0),
                      title: Text(snapshot.data![index].nome_prodotto),
                    ),
                  ),
                );

              },
            );
          }
          else {
            /*
            Se lo snapshot non contiene dati, viene mostrato un indicatore di progresso circolare (rotellina che gira)
             */
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
        ),
          ),
          Expanded(
              child:
                  /*
                  Lista che mostra, se esistono, le ricette presenti nel database di firebase,
                  che tra i loro ingredienti hanno quelli in dispensa
                   */
              ListView.builder(
                  itemCount: ricetteFilter.length,
                  itemBuilder: (_, index) {
                    var urlImage = "https://firebasestorage.googleapis.com/v0/b/gino-49a3d.appspot.com/o/images%2F" +
                        ricetteFilter[index].image +
                        "?alt=media&token=323e6eb7-b6e6-4b59-9ce8-f8936cf3cd29";
                    return GestureDetector(
                      /*
                      Al clic sulla card relativa ad una specifica ricetta, ti rimanda a quella ricetta nel dettaglio
                      dove sono presenti tutte le informazioni relative a quest'ultima
                       */
                        onTap: () async {
                          List<String> manc=[];
                          var lista=[];
                          var ingre=ricetteFilter[index].ingredienti;
                          var listaa = await this.handler.retriveProdotti();
                          for ( var li in listaa){
                            lista.add(li.nome_prodotto.toLowerCase());
                          }

                          for (var ing in ingre){
                            if (!lista.contains(ing.toString().toLowerCase())){
                              manc.add(ing.toString());
                            }
                          }
                          _displaySpesaDialog(context, manc,index);

                        },

                        child: CardUI(ricetteFilter[index].nome, urlImage));
                  })
          ),
          FloatingActionButton.extended(
            /*
            Bottone che se cliccato, cerca le ricette di Firebase che contengono tra gli ingredienti, gli
             elementi presenti nella dispensa
             */
            onPressed: () async {
              ingredientiFilter.clear();
              var listaa = await this.handler.retriveProdotti();
              ingredientiFilter.addAll(listaa);

              //ricetteFilter = ricettaList;
              for (var ric in ricettaList){
              for (var ingr in ingredientiFilter){

                  List<String> ingedients = [];
                  for (var ingre in ric.ingredienti){

                    ingedients.add(ingre.toString().toLowerCase());
                    //ricetteFilter.add(ric);
                  } if (ingedients.contains(ingr.nome_prodotto.toString().toLowerCase())){
                    ricetteFilter.add(ric);
                   }
                }
              }

              setState(() {
                //
              });
            },
            label: const Text('Cerca'),
            icon: const Icon(Icons.search),
            backgroundColor: Colors.redAccent,
          ),
          SizedBox(height: 12.0),
          FloatingActionButton.extended(
            /*
            Bottone che mostra l'Alert Dialog (descritto sopra), per aggiungere un prodotto
            in dispensa
             */
            onPressed: () {
              _displayTextInputDialog(context);
            },
            label: const Text('Aggiungi'),
            icon: const Icon(Icons.add),
            backgroundColor: Colors.redAccent,
          ),
      ]
        ),
      ),


    );
  }
}
Widget CardUI(String nome, String image){
  /*
  Card che viene mostrata nella ListView, e che contiene nome e foto delle singole ricette
   */
  return  Card(
    elevation: 10,
    margin: EdgeInsets.all(5),
    //color: Color(0xfff13746),
    child: Container(
      //color: Colors.white,
      margin: EdgeInsets.all(1),
      padding: EdgeInsets.all(8),
      child: Column(
        children:<Widget> [
          Image.network(
            image,
            fit: BoxFit.cover,
            height: 100,
            width: 100,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(child:SpinKitPouringHourglass(
                color: Colors.red,));
            },
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                "assets/images/coltforc.png",
                fit: BoxFit.cover,
                height: 100,
                width: 100,
              );//do something
            },
          ),
          //SizedBox(height: 1,),
          Text(nome,maxLines: 3,),

        ],
      ),

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
