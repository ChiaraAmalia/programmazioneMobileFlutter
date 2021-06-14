
import 'package:easycookingflutter/RicetteCercaNoLogin.dart';
import 'package:easycookingflutter/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:easycookingflutter/services/auth.dart';

import '../MyFlutterApp.dart';

class Logout extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Easy Cooking"),
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
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 150.0, horizontal: 50.0),
          alignment: Alignment.center,

            child:Column(
                children: [

                  RichText(text:TextSpan(text:'Sei sicuro di voler effettuare il logout? Se non sei loggato non potrai inserire le tue ricette!',  style: TextStyle(color: Colors.red,fontSize: 24))),

                  SizedBox(height: 30.0),
                  RaisedButton(
                      color: Colors.red,
                      child: Text(
                        'Logout',
                        style: TextStyle(color: Colors.white),
                      ),
                    onPressed: () async{
                    await _auth.signOut();
                    }
                  ),
                ])

        )
    );
  }
}
