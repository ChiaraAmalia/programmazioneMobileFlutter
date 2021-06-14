import 'package:easycookingflutter/MyFlutterApp.dart';
import 'package:easycookingflutter/Model/Prodotto.dart';
import 'package:easycookingflutter/model/Ricetta.dart';
import 'package:easycookingflutter/pages/Contattaci.dart';
import 'package:easycookingflutter/pages/InserisciRicetta.dart';
import 'package:easycookingflutter/pages/Ispirami.dart';
import 'package:easycookingflutter/pages/RicetteCercaPage.dart';
import 'package:easycookingflutter/pages/RicetteTue.dart';
import 'package:easycookingflutter/pages/Spesa.dart';
import 'package:easycookingflutter/services/DatabaseHandler.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:easycookingflutter/pages/Dispensa.dart';
import 'package:path/path.dart';


class Ricette extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
    );
  }
}

class RicetteCerca extends StatefulWidget {
  RicetteCerca({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _RicetteCercaState createState() => _RicetteCercaState();
}

class _RicetteCercaState extends State<RicetteCerca> {


  int _selectedIndex = 1;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
   List _widgetOptions = [
    Dispensa(),
    RicetteCercaPage(),
    RicetteTue(),
    Spesa(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(MyFlutterApp.info_outline, color: Colors.white,),
            tooltip: 'Go to the next page',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Info'),
                    ),
                    body: SingleChildScrollView(
                      child:Column(
                    children:[
                      Align(
                        alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                        text:'Come iniziare? \n',
                            style: TextStyle(color: Colors.red, fontSize:24,),
                           children: <InlineSpan>[
                             WidgetSpan(
                                 child: SizedBox(
                                   child:  Image.asset(
                                     "assets/images/food.png",
                                     fit: BoxFit.cover,
                                   ),
                                 )),
                             TextSpan(text:'Cerca Ricette:\n', style: TextStyle(color: Colors.red,fontSize: 24)),],),),),
                             Text('In questa prima sezione è possibile cercare le ricette secondo il nome, la categoria oppure la sua origine. Cliccando su \'Vedi Ricette\' verranno restituite tutte le ricette presenti nel database. All\'interno della ricetta verranno visualizzate tutte le informazioni utili alla preparazione del piatto selezionato, inoltre è possibile condividere la ricetta oppure salvarla così da poterne usufruire senza la connessione ad internet.\n'),
                        RichText(text:TextSpan(text:'Dispensa\n',  style: TextStyle(color: Colors.red,fontSize: 24))),
                        Text('Nella sezione Dispensa è possibile registrare gli alimenti presenti nella vostra dispensa:  cliccando su \'Aggiungi\', si aprirà una piccola form in cui è possibile aggiungere l\'ingrediente desiderato. Per eliminare un elemento è sufficiente scorrere lo stesso verso sinistra. Infine è possibile effettuare un ricerca delle ricette secondo gli elementi inseriti.\n'),
                      RichText(text:TextSpan(text:'Lista Spesa\n',style: TextStyle(color: Colors.red, fontSize: 24))),
                        Text('Consiste di un\'effettiva lista della spesa: se, una volta visionata una ricetta, l\'utente dovesse rendersi conto di non avere un ingrediente potrà andarlo ad aggiungere in questa area. Anche in questo caso, per eliminare un elemento sarà sufficiente scorrere lo stesso verso sinistra.\n'),
                    RichText(text:TextSpan(text:'Tue Ricette\n',  style: TextStyle(color: Colors.red,fontSize: 24))),
                          Text('\'Ricette Tue\' è una funzionalità disponibile solo per gli utenti che hanno effettuato la registrazione: permette di creare ricette personalizzate secondo i gusti e le idee dell\'utente\n'),
                      RichText(text:TextSpan(text:'Login\n',  style: TextStyle(color: Colors.red,fontSize: 24))),
                          Text('Questa sezione sarà visibile solo agli utenti che non hanno effettuato la registrazione. Permette di effettuare il login oppure di registrarsi.\n'),
                        RichText(text:TextSpan(text:'Offline\n',  style: TextStyle(color: Colors.red,fontSize: 24))),
                          Text('Possiamo accedere a questa sezione solo se l\'utente è registrato, semplicemente cliccando sul pulsante RicetteTue. Qui potremo visualizzare ed accedere alle ricette che abbiamo salvato in precedenza.\n'),
                  RichText(text:TextSpan(text:'Ispirami\n',  style: TextStyle(color: Colors.red,fontSize: 24))),
                          Text('Non sai cosa cucinare? Pur di non pensare accetteresti un piatto a base di frattaglie di cavallo? Questa è la funzione che fa per te. \'Ispierami\' genera per te una ricetta casuale dal nostro database, a tuo rischio e pericolo :)\n'),
                  RichText(text:TextSpan(text:'Contattaci\n',  style: TextStyle(color: Colors.red,fontSize: 24))),
                          Text('Se hai domande puoi inviarci una mail. Se invece sei interessato ad ulteriori ricette puoi trovarci su instagram, dove le nostre esperte sono pronte a deliziarti con fantastici piatti!\n'),

                      ]),
                    ),
                    );
                },
              ));
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children:  <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                image: DecorationImage(image: AssetImage("assets/images/food.png"),
                fit:BoxFit.cover)
              ),
              child: Text(
                'Easy Cooking',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Contattaci'),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/contattaci');
              },
            ),
            ListTile(
              leading: Icon(Icons.wb_incandescent_outlined),
              title: Text('Ispirami'),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/ispirami');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/logout');
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.refrigerator ,color: Colors.red),
            label: 'Dispensa',
          ),
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.rolling_pin, color: Colors.red),
            label: 'Cerca Ricette',
          ),
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.apron, color: Colors.red),
            label: 'RicetteTue',
          ),
          BottomNavigationBarItem(
            icon: Icon(MyFlutterApp.vegetable_box, color: Colors.red),
            label: 'ListaSpesa',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }
}