import 'package:easycookingflutter/Model/ricetta.dart';
import 'package:easycookingflutter/MyFlutterApp.dart';
import 'package:easycookingflutter/Model/Prodotto.dart';
import 'package:easycookingflutter/services/DatabaseHandler.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'RicetteDettaglio.dart';


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
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
        ),
          ),
          Expanded(
              child:
              ListView.builder(
                  itemCount: ricetteFilter.length,
                  itemBuilder: (_, index) {
                    var urlImage = "https://firebasestorage.googleapis.com/v0/b/gino-49a3d.appspot.com/o/images%2F" +
                        ricetteFilter[index].image +
                        "?alt=media&token=323e6eb7-b6e6-4b59-9ce8-f8936cf3cd29";
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => RicetteDettaglio(),
                            settings: RouteSettings(
                              arguments: ricetteFilter[index],
                            ),));
                        },

                        child: CardUI(ricetteFilter[index].nome, urlImage));
                  })
          ),
          FloatingActionButton.extended(
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
