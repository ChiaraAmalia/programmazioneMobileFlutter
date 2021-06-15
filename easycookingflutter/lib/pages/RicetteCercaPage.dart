
import 'package:firebase_storage/firebase_storage.dart';
import 'package:easycookingflutter/Model/ricetta.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'RicetteDettaglio.dart';

/*
Schermata nella quale vengono mostrate tutte le ricette presenti su firebase e dove si può
eseguire una ricerca basata sul nome della ricetta, sulla sua categoria e sulla sua origine .
La ricerca può essere combinata e ciò viene fatto in AND
 */

class RicetteCercaPage extends StatefulWidget{
  RicetteCercaPage({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  _RicetteCercaPageState createState() => _RicetteCercaPageState();
}

class _RicetteCercaPageState extends State<RicetteCercaPage> {
  List<Ricetta> ricettaList = [];
  List<Ricetta> ricetteFilter = [];
  String cate="Seleziona Categoria";
  String ori="Seleziona origine";
  TextEditingController nomeController = TextEditingController();
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
            children: MediaQuery.of(context).orientation==Orientation.portrait ? <Widget>[
              Column(
                  children: <Widget>[
              Container(
                width: 200.0,
              child: TextField(
                controller: nomeController,
                decoration: InputDecoration(
                    hintText: 'Cerca una ricetta'
                ),
                onChanged: (text) {
                  /*
                  ricerca le ricette che all'interno del loro nome hanno il testo scritto
                  nell'input text
                   */
                  text = text.toLowerCase();
                  setState(() {
                    ricetteFilter = ricetteFilter.where((ric) {
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
                      hint: Text(cate),
                      isExpanded: true,
                      onChanged: (newCat){
                        cate=newCat.toString();
                        newCat = newCat.toString().toLowerCase();
                        setState(() {
                          /*
                          Se viene selezionata una categoria, mostra solo le ricette appartenenti a
                          quest'ultima
                           */
                          if (newCat.toString()=="Seleziona Categoria"){
                            ricetteFilter = ricettaList;
                          } else {
                          ricetteFilter = ricetteFilter.where((ric) {
                            var recipe = ric.recipeCategory.toLowerCase();
                            return recipe.contains(newCat.toString());
                          }).toList();}

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
                          hint: Text(ori),
                          isExpanded: true,
                          onChanged: (newCat){
                            ori=newCat.toString();
                            newCat = newCat.toString().toLowerCase();
                            setState(() {
                          /*
                          Se viene selezionata un'origine, mostra solo le ricette appartenenti a
                          quest'ultima
                           */
                            if (newCat.toString()=="Seleziona Origine"){
                             ricetteFilter = ricettaList;
                             } else {
                              ricetteFilter = ricetteFilter.where((ric) {
                                var recipe = ric.recipeCuisine.toLowerCase();
                                return recipe.contains(newCat.toString());
                              }).toList();}

                            });
                          },

                          items: Cucine.map((valueItem) {

                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                        )

                    ),
                    Container(
                      child: Column(
                      children: [
                        ElevatedButton(onPressed: () { setState(() {
                          /*
                          Bottone che se premuto azzera la ricerca e mostra nuovamente tutte le ricette
                          presenti su firebase
                           */
                        ricetteFilter=ricettaList;
                        cate="Seleziona Categoria";
                        ori="Seleziona Origine";
                        nomeController.clear();
                      }); }, child: Text("Azzera ricerca"),

                      ),
                        ElevatedButton(onPressed: () { setState(() {
                          /*
                          Bottone che se premuto aggiorna la ricerca con i nuovi parametri passati
                           */
                          ricetteFilter=ricettaList;
                          if(nomeController.text.isNotEmpty){
                            ricetteFilter=ricettaList.where((element) {
                              var recipe = element.nome.toLowerCase();
                              return recipe.contains(nomeController.text);
                            }).toList();
                          }
                          {
                            if (cate != "Seleziona Categoria"){
                              ricetteFilter = ricetteFilter.where((ric) {
                                var recipe = ric.recipeCategory.toLowerCase();
                                return recipe.contains(cate.toLowerCase());
                              }).toList();
                            }
                          }
                          {
                            if (ori != "Seleziona Origine"){
                              ricetteFilter = ricetteFilter.where((ric) {
                                var recipe = ric.recipeCuisine.toLowerCase();
                                return recipe.contains(ori.toLowerCase());
                              }).toList();
                            }
                          }
                        }); }, child: Text("Aggiorna ricerca"),

                        ),
    ]
                      )
                    )
                  ]),
              Expanded(
                  child: ricetteFilter.length == 0 ? Align(
                      alignment: Alignment.center, child: Center(
                      child:
                      Text("Nessuna ricetta corrisponde ai criteri di ricerca", textAlign: TextAlign.center,))) :
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
            ] : <Widget>[
              Column(
        children:[
              Row(
                  children: <Widget>[
                    Container(
                      width: 200.0,
                      child: TextField(
                        controller: nomeController,
                        decoration: InputDecoration(
                            hintText: 'Cerca una ricetta'
                        ),
                        onChanged: (text) {
                          /*
                  ricerca le ricette che all'interno del loro nome hanno il testo scritto
                  nell'input text
                   */
                          text = text.toLowerCase();
                          setState(() {
                            ricetteFilter = ricetteFilter.where((ric) {
                              var recipe = ric.nome.toLowerCase();
                              return recipe.contains(text);
                            }).toList();
                          });
                        },

                      ),),

                    Container(
                        width: 200.0,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child:
                        DropdownButton(
                          hint: Text(cate),
                          isExpanded: true,
                          onChanged: (newCat){
                            cate=newCat.toString();
                            newCat = newCat.toString().toLowerCase();
                            setState(() {
                              /*
                          Se viene selezionata una categoria, mostra solo le ricette appartenenti a
                          quest'ultima
                           */
                              if (newCat.toString()=="Seleziona Categoria"){
                                ricetteFilter = ricettaList;
                              } else {
                                ricetteFilter = ricetteFilter.where((ric) {
                                  var recipe = ric.recipeCategory.toLowerCase();
                                  return recipe.contains(newCat.toString());
                                }).toList();}

                            });
                          },

                          items: Categorie.map((valueItem) {

                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                        )

                    ),
                    Container(
                        width: 200.0,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child:
                        DropdownButton(
                          hint: Text(ori),
                          isExpanded: true,
                          onChanged: (newCat){
                            ori=newCat.toString();
                            newCat = newCat.toString().toLowerCase();
                            setState(() {
                              /*
                          Se viene selezionata un'origine, mostra solo le ricette appartenenti a
                          quest'ultima
                           */
                              if (newCat.toString()=="Seleziona Origine"){
                                ricetteFilter = ricettaList;
                              } else {
                                ricetteFilter = ricetteFilter.where((ric) {
                                  var recipe = ric.recipeCuisine.toLowerCase();
                                  return recipe.contains(newCat.toString());
                                }).toList();}

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

                    Container(
                        child: Row(
                            children: [
                              ElevatedButton(onPressed: () { setState(() {
                                /*
                          Bottone che se premuto azzera la ricerca e mostra nuovamente tutte le ricette
                          presenti su firebase
                           */
                                ricetteFilter=ricettaList;
                                cate="Seleziona Categoria";
                                ori="Seleziona Origine";
                                nomeController.clear();
                              }); }, child: Text("Azzera ricerca"),

                              ),
                              ElevatedButton(onPressed: () { setState(() {
                                /*
                          Bottone che se premuto aggiorna la ricerca con i nuovi parametri passati
                           */
                                ricetteFilter=ricettaList;
                                if(nomeController.text.isNotEmpty){
                                  ricetteFilter=ricettaList.where((element) {
                                    var recipe = element.nome.toLowerCase();
                                    return recipe.contains(nomeController.text);
                                  }).toList();
                                }
                                {
                                  if (cate != "Seleziona Categoria"){
                                    ricetteFilter = ricetteFilter.where((ric) {
                                      var recipe = ric.recipeCategory.toLowerCase();
                                      return recipe.contains(cate.toLowerCase());
                                    }).toList();
                                  }
                                }
                                {
                                  if (ori != "Seleziona Origine"){
                                    ricetteFilter = ricetteFilter.where((ric) {
                                      var recipe = ric.recipeCuisine.toLowerCase();
                                      return recipe.contains(ori.toLowerCase());
                                    }).toList();
                                  }
                                }
                              }); }, child: Text("Aggiorna ricerca"),

                              ),
                            ]
                        )
                    )
                  ]),
              
              Expanded(
                  child: ricetteFilter.length == 0 ? Align(
                      alignment: Alignment.center, child: Center(
                      child:
                      Text("Nessuna ricetta corrisponde ai criteri di ricerca", textAlign: TextAlign.center,))) :
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
            ]
        ));
  }
}

  Widget CardUI(String nome, String image){
    return  Card(
      elevation: 10,
      margin: EdgeInsets.all(5),
      child: Container(
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

