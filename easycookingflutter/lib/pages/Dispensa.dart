import 'package:easycookingflutter/MyFlutterApp.dart';
import 'package:easycookingflutter/Prodotto.dart';
import 'package:easycookingflutter/services/DatabaseHandler.dart';
import 'package:flutter/material.dart';

class Dispensa extends StatefulWidget{

  @override
  _DispensaState createState() => _DispensaState();
}

class _DispensaState extends State<Dispensa> {

//DATABASE
  late DatabaseHandler handler;

  @override
  void initState() {
    super.initState();
    this.handler = DatabaseHandler();
    this.handler.initializeDB().whenComplete(() async {
      await this.aggiungiProdotti();
      setState(() {});
    });
  }
  Future<int> aggiungiProdotti() async {
    Prodotto firstProduct = Prodotto(nome_prodotto: "gelato");
    Prodotto secondProduct = Prodotto(nome_prodotto: "patate");
    List<Prodotto> listOfProdotti = [firstProduct, secondProduct];
    return await this.handler.inserisciProdotto(listOfProdotti);
  }

  @override
  Widget build(BuildContext context){

    return Center(
      child:FutureBuilder(
        future: this.handler.retriveProodotti(),
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
                  key: ValueKey<String>(snapshot.data![index].nome_prodotto!),
                  onDismissed: (DismissDirection direction) async {
                    await this.handler.cancellaProdotto(snapshot.data![index].nome_prodotto!);
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
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
