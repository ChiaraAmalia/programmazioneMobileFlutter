
import 'package:firebase_storage/firebase_storage.dart';
import 'package:easycookingflutter/Model/ricetta.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'RicetteDettaglio.dart';



class RicetteCercaPage extends StatefulWidget{
  RicetteCercaPage({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  _RicetteCercaPageState createState() => _RicetteCercaPageState();
}

class _RicetteCercaPageState extends State<RicetteCercaPage> {
  List<Ricetta> ricettaList = [];
  List<Ricetta> ricetteFilter = [];
  //late Object Categoria;
  List<String> Categorie = [
    "Dolci", "Bevande & Cocktail", "Pane & Pizza", "Ricette base", "Marmellate & Conserve", "Secondi Piatti", "Primi"
  ];
  List<String> Cucine = [
    "Italiana", "Indiana", "Americana", "Cinese", "Francese", "Spagnola", "Giapponese","Austriaca","Marocchina","Australiana",
    "Hawaiiana","Brasiliana","Cubana","Inglese","Messicana","Polinesiana","Portoricana","Singaporiana","Turca","Tedesca",
    "Tunisina","Greca","Ungherese","Svedese","Africana","SriLanka","Taiwan","Tailandese"
  ];
  @override
  void initState() {
    super.initState();
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
      ricetteFilter = ricettaList;
      setState(() {
        //
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ricettaList.length == 0 ? Align(
            alignment: Alignment.center, child: Center(
            child:
            SpinKitCubeGrid(
              color: Colors.red,
              size: 80.0,
            ))) :
        Column(
            children: <Widget>[
              Column(
                  children: <Widget>[
              Container(
                width: 200.0,
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Cerca una ricetta'
                ),
                onChanged: (text) {
                  text = text.toLowerCase();
                  setState(() {
                    ricetteFilter = ricettaList.where((ric) {
                      var recipe = ric.nome.toLowerCase();
                      return recipe.contains(text);
                    }).toList();
                  });
                },

              ),),]),

              SizedBox(height: 12.0),
              Column(
                children:<Widget>[
                  Container(
                    width: 200.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(15)
                    ),
                      child:
                    DropdownButton(
                      hint: Text('Seleziona Categoria'),
                      //value: Categoria,
                      onChanged: (newCat){
                        //Categoria = newCat.toString();
                        newCat = newCat.toString().toLowerCase();
                        setState(() {
                          ricetteFilter = ricettaList.where((ric) {
                            var recipe = ric.recipeCategory.toLowerCase();
                            return recipe.contains(newCat.toString());
                          }).toList();

                          });
                        },

                      items: Categorie.map((valueItem) {

                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem),
                        );
                      }).toList(),
                    )

              ),]),
              SizedBox(height: 12.0),
              Column(
                  children:<Widget>[
                    Container(
                      width: 200.0,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child:
                        DropdownButton(
                          hint: Text('Seleziona Origine'),
                          //value: Categoria,
                          onChanged: (newCat){
                            //Categoria = newCat.toString();
                            newCat = newCat.toString().toLowerCase();
                            setState(() {
                              ricetteFilter = ricettaList.where((ric) {
                                var recipe = ric.recipeCuisine.toLowerCase();
                                return recipe.contains(newCat.toString());
                              }).toList();

                            });
                          },

                          items: Cucine.map((valueItem) {

                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                        )

                    ),]),
              Expanded(
                  child:
                  ListView.builder(
                      itemCount: ricetteFilter.length,
                      itemBuilder: (_, index) {
                        var urlImage = "https://firebasestorage.googleapis.com/v0/b/gino-49a3d.appspot.com/o/images%2F" +
                            ricetteFilter[index].image +
                            "?alt=media&token=323e6eb7-b6e6-4b59-9ce8-f8936cf3cd29";
                        return GestureDetector(
                          // Quando il child è cliccato apre la pagina istagram.
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => RicetteDettaglio(),
                                settings: RouteSettings(
                                  arguments: ricetteFilter[index],
                                ),));
                            },

                            child: CardUI(ricetteFilter[index].nome, urlImage));
                      })
              )
            ]));
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

