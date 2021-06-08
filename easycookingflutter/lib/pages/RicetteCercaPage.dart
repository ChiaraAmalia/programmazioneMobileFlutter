
import 'package:firebase_storage/firebase_storage.dart';
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
    body: ricettaList.length == 0 ? Column(children:[ Text("Ricette non disponibili", style: TextStyle(fontSize: 30),),CircularProgressIndicator()]):
        ListView.builder(
          itemCount: ricettaList.length,
            itemBuilder: (_, index){
              //var urlImage="https://upload.wikimedia.org/wikipedia/commons/6/61/Crystal_128_error.png";
           /* var storage = FirebaseStorage.instance.ref().child("images").child(ricettaList[index].image).getDownloadURL().then((result) {
              setState(() {
                if (result is String)
                   urlImage = result.toString(); //use toString to convert as String
              });
            });*/
              var urlImage="https://firebasestorage.googleapis.com/v0/b/gino-49a3d.appspot.com/o/images%2F"+ricettaList[index].image+"?alt=media&token=323e6eb7-b6e6-4b59-9ce8-f8936cf3cd29";
              return CardUI(ricettaList[index].nome, urlImage);
            })
    );
  }

  Widget CardUI(String nome, String image){
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(5),
      //color: Color(0xfff13746),
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.all(1),
        padding: EdgeInsets.all(8),
        child: Column(
          children:<Widget> [
            Image.network(
              image,
              fit: BoxFit.cover,
              height: 100,
              width: 100,
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
  }
