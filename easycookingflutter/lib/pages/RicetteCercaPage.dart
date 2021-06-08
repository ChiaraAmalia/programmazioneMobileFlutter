

import 'package:easycookingflutter/Model/ricetta.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class RicetteCercaPage extends StatefulWidget{
  RicetteCercaPage({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  _RicetteCercaPageState createState() => _RicetteCercaPageState();
}

class _RicetteCercaPageState extends State<RicetteCercaPage> {
  List<Ricetta> ricettaList = [];
  @override
  void initState() {
    super.initState();
    DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("");
    dbRef.once().then((DataSnapshot dataSnapshot){
      ricettaList.clear();
      //var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;

      for(var val in values){
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
          val["recipeCategory"] ,
          val["recipeCuisine"],
          val["totalTime"],
          val["vegano"],
        );
        ricettaList.add(ric);
      }
      setState(() {
        //
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: ricettaList.length == 0 ? Center(child: Text("Ricette non disponibili", style: TextStyle(fontSize: 30),)):
        ListView.builder(
          itemCount: ricettaList.length,
            itemBuilder: (_, index){
              return CardUI(ricettaList[index].nome, ricettaList[index].image);
            })
    );
  }

  Widget CardUI(String nome, String image){
    return Card(
      margin: EdgeInsets.all(15),
      color: Color(0xff122fc3),
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.all(1),
        padding: EdgeInsets.all(10),
        child: Column(
          children:<Widget> [
            Image.network(image, fit: BoxFit.cover, height: 100,),
            SizedBox(height: 1,),
            Text(nome),

          ],
        ),
      ),

    );
  }
  }
