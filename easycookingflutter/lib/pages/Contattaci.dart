import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/MyFlutterApp.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';
/*
Schermata che visualizza i contatti dell'applicazione, ovvero che permette
di visitare le pagine Istagram @ricette_a_8bit, @mela_magno o di mandare una
mail all'indirizzo e-mail predisposto per l'applicazione
 */
class Contattaci extends StatefulWidget {
  Contattaci({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  _ContattaciState createState() => _ContattaciState();
}

class _ContattaciState extends State<Contattaci> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              /*
              Icona che se cliccata porta ad un'altra schermata dove si possono leggere le info relative all'applicazione
               */
              icon: const Icon(MyFlutterApp.info_outline, color: Colors.white,),
              tooltip: 'Info',
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
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              GestureDetector(
                /* Quando il child è cliccato apre la pagina istagram.
                @mela_magno
                 */
                onTap: () async {
                  var url = 'https://www.instagram.com/mela_magno/';

                  if (await canLaunch(url)) {
                    await launch(
                      url,
                      universalLinksOnly: true,
                    );
                  } else {
                    throw 'Non riesco ad aprire Instagram';
                  }
                },
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: ShapeDecoration(
                      color: Colors.orange[50],
                      image: DecorationImage(
                          image: AssetImage("assets/images/mela.JPG"),
                          fit: BoxFit.fitWidth),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(20))),
                  width: 350,
                  height: 400,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Mela Magno",
                          style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                /*
                 Quando il child è cliccato apre la pagina istagram.
                 @ricette_a_8bit
                 */
                onTap: () async {
                  var url = 'https://www.instagram.com/ricette_a_8bit/';

                  if (await canLaunch(url)) {
                    await launch(
                      url,
                      universalLinksOnly: true,
                    );
                  } else {
                    throw 'Non riesco ad aprire Instagram';
                  }
                },
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: ShapeDecoration(
                      color: Colors.orange[50],
                      image: DecorationImage(
                          image: AssetImage("assets/images/bitChia.JPG"),
                          fit: BoxFit.fitWidth),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(20))),
                  width: 350,
                  height: 400,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Ricette a 8 bit",
                          style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.all(16),
                  /*
                  Bottone che se cliccato ti permette di inviare una mail all'indirizzo
                  predisposto per l'app
                   */
                  child: CupertinoButton.filled(
                    child: Text('Mandaci una E-mail'),
                    onPressed: () async {
                      final url = Mailto(
                        to: [
                          'easycookingclm@gmail.com',
                        ],
                        cc: [],
                        bcc: [],
                        subject: 'EasyCooking Aiutami Tu!',
                        body:
                            'Ciao Mi piace molto la vostra App!👍 Potreste aiutarmi con...',
                      ).toString();
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        showCupertinoDialog(
                          context: context,
                          builder: MailClientOpenErrorDialog(url: url).build,
                        );
                      }
                    },
                  )),
            ]),
          ),
        ));
  }
}


/*
    Metodo che lancia un Alert Dialog se l'URL specificato non riesce
    ad essere lanciato
*/
class MailClientOpenErrorDialog extends StatelessWidget {
  final String url;

  const MailClientOpenErrorDialog({Key? key, required this.url})
      : assert(url != ''),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Launch Error'),
      content: Text('Non riesco ad aprire:\n$url'),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
