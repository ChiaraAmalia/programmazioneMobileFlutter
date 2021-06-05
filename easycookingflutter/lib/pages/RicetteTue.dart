import 'dart:typed_data';

import 'package:easycookingflutter/Model/RicettaInserimento.dart';
import 'package:easycookingflutter/MyFlutterApp.dart';
import 'package:easycookingflutter/Model/Prodotto.dart';
import 'package:easycookingflutter/pages/InserisciRicetta.dart';
import 'package:easycookingflutter/pages/RicetteTueDettaglio.dart';
import 'package:easycookingflutter/services/DatabaseHandler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class RicetteTue extends StatefulWidget{
  RicetteTue({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  _RicetteTueState createState() => _RicetteTueState();
}

class _RicetteTueState extends State<RicetteTue> {

//DATABASE
  late DatabaseHandler handler;

  @override
  void initState() {
    super.initState();
    this.handler = DatabaseHandler();
    this.handler.initializeDB();
  }

//DATABASE

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: this.handler.retriveRicetteTue(),
          builder: (BuildContext context,
              AsyncSnapshot<List<RicettaInserimento>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  String nome=snapshot.data![index].nome_ricetta.toString();
                  String ingr = snapshot.data![index].ingredienti_ricetta.toString();
                  String cook = snapshot.data![index].cookTime.toString();
                  String prep = snapshot.data![index].prepTime.toString();
                  String tot = snapshot.data![index].totalTime.toString();
                  Uint8List foto = snapshot.data![index].fotoRicetta;
                  String porz = snapshot.data![index].porzioni.toString();
                  String prepa = snapshot.data![index].preparazione.toString();
                  RicettaDettaglioArgomenti argomento = RicettaDettaglioArgomenti(nome,ingr,cook,prep,tot,foto,porz,prepa);
                  return Dismissible(
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(Icons.delete_forever),
                    ),
                    key: ValueKey<String>(snapshot.data![index].nome_ricetta),
                    onDismissed: (DismissDirection direction) async {
                      await this.handler.cancellaRicettaTua(snapshot
                          .data![index].nome_ricetta);
                      setState(() {
                        snapshot.data!.remove(snapshot.data![index]);
                      });
                    },
                    child: Card(
                      child: ListTile(
                        onTap: (){

                          Navigator.push(context, MaterialPageRoute(builder: (context) => RicetteTueDettaglio(),
                            settings: RouteSettings(
                              arguments: argomento,
                            ),));
                        },
                        contentPadding: EdgeInsets.all(8.0),
                        title: Text(snapshot.data![index].nome_ricetta),
                        leading: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: 44,
                            minHeight: 44,
                            maxWidth: 44,
                            maxHeight: 44,
                          ),
                          child: Image.memory(snapshot.data![index].fotoRicetta, fit: BoxFit.cover),
                        ),

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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => InserisciRicetta()));
        },
        label: const Text('Aggiungi'),
        icon: const Icon(MyFlutterApp.apron),
        backgroundColor: Colors.redAccent,
      ),

    );
  }
}

class RicettaDettaglioArgomenti{
  final String nome_ricetta;
  final String ingredienti_ricetta;
  final String cookTime;
  final String prepTime;
  final String totalTime;
  final Uint8List fotoRicetta;
  final String porzioni;
  final String preparazione;

  RicettaDettaglioArgomenti(this.nome_ricetta, this.ingredienti_ricetta, this.cookTime,this.prepTime,this.totalTime,this.fotoRicetta,this.porzioni,this.preparazione);
}