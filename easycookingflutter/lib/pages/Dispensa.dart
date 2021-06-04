import 'package:easycookingflutter/MyFlutterApp.dart';
import 'package:easycookingflutter/Prodotto.dart';
import 'package:easycookingflutter/services/DatabaseHandler.dart';
import 'package:flutter/material.dart';


class Dispensa extends StatefulWidget{
  Dispensa({Key? key, this.title}) : super(key: key);
  final String? title;
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
        child:FutureBuilder(
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
            return Center(child: Text('La dispensa è vuota?'));
          }
        },
      ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _displayTextInputDialog(context);
        },
        label: const Text('Aggiungi'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.redAccent,
      ),

    );
  }

  Future<int> aggiungiProdotti() async {
    Prodotto firstProduct = Prodotto(nome_prodotto: "gelato");
    Prodotto secondProduct = Prodotto(nome_prodotto: "patate");
    List<Prodotto> listOfProdotti = [firstProduct, secondProduct];
    return await this.handler.inserisciProdotto(listOfProdotti);
  }
}
