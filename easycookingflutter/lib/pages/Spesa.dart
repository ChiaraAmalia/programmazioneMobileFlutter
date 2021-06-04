import 'package:easycookingflutter/MyFlutterApp.dart';
import 'package:easycookingflutter/Model/Prodotto.dart';
import 'package:easycookingflutter/services/DatabaseHandler.dart';
import 'package:flutter/material.dart';


class Spesa extends StatefulWidget{
  Spesa({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  _SpesaState createState() => _SpesaState();
}

class _SpesaState extends State<Spesa> {

//DATABASE
  late DatabaseHandler handler;

  @override
  void initState() {
    super.initState();
    this.handler = DatabaseHandler();
    this.handler.initializeDB();
  }

//DATABASE

  //ALERT DIALOG
  TextEditingController _textFieldController = TextEditingController();

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Aggiungi alla lista della spesa'),
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
                    this.handler.inserisciUnoSpesa(prod);
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: this.handler.retriveSpesa(),
          builder: (BuildContext context,
              AsyncSnapshot<List<Prodotto>> snapshot) {
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
                      await this.handler.cancellaProdottoSpesa(snapshot
                          .data![index].nome_prodotto);
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _displayTextInputDialog(context);
        },
        label: const Text('Devo Comprare'),
        icon: const Icon(Icons.shopping_cart),
        backgroundColor: Colors.redAccent,
      ),

    );
  }
}