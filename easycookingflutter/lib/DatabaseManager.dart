/*import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager{
  final CollectionReference ricetteList =
        Firestore.instance.collection('cook');

  Future<void> createRicetta(
      List Ingredienti, List keywords, List quantita, List unita,
      String cookTime,  String descrizione, String image, String nome, String porzioni, String prepTime,
      String preparazione, String recipeCategory, String recipeCuisine, String totalTime,
      bool vegano, String id) async{
    return await ricetteList.document(id).setData({
      'Ingredienti': Ingredienti,
      'unita':unita,
      'quantita':quantita,
      'keywords': keywords,
      'cookTime':cookTime,
      'descrizione':descrizione,
      'image':image,
      'nome':image,
      'porzioni':porzioni,
      'prepTime':prepTime,
      'preparazione':preparazione,
      'recipeCategory':recipeCategory,
      'recipeCuisine':recipeCuisine,
      'totalTime':totalTime,
      'vegano':vegano,
    });}


    Future getRicette() async{

    List listaRicette = [];
    
      try{
          await ricetteList.getDocuments().then((querySnapshot){
            querySnapshot.documents.forEach((element) {
              listaRicette.add(element.data);
            });
          } );
          return listaRicette;
      }catch(e){
        print(e.toString());
        return null;
      }
    }
  }*/
