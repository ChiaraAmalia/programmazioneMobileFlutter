import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easycookingflutter/MyFlutterApp.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';


class Contattaci extends StatefulWidget {
  Contattaci({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _ContattaciState createState() => _ContattaciState();
}

class _ContattaciState extends State<Contattaci> {

  @override
  Widget build(BuildContext context) {
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
                          child: RichText(
                            text: TextSpan(
                              text:'Come iniziare? \n',
                              style: TextStyle(color: Colors.red, fontSize:24),
                              children: <InlineSpan>[
                                WidgetSpan(
                                    child: SizedBox(
                                      child:  Image.asset(
                                        "assets/images/food.png",
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                TextSpan(text:'Cerca Ricette:\n', style: TextStyle(color: Colors.red,fontSize: 24)),
                                TextSpan(text:'In questa prima sezione è possibile cercare le ricette secondo il nome, la categoria oppure la sua origine. Cliccando su \'Vedi Ricette\' verranno restituite tutte le ricette presenti nel database. All\'interno della ricetta verranno visualizzate tutte le informazioni utili alla preparazione del piatto selezionato, inoltre è possibile condividere la ricetta oppure salvarla così da poterne usufruire senza la connessione ad internet.\n',
                                    style: TextStyle(color: Colors.black, fontSize: 18)),
                                TextSpan(text:'Dispensa\n',  style: TextStyle(color: Colors.red,fontSize: 24)),
                                TextSpan(text:'Nella sezione Dispensa è possibile registrare gli alimenti presenti nella vostra dispensa:  cliccando su \'Aggiungi\', si aprirà una piccola form in cui è possibile aggiungere l\'ingrediente desiderato. Per eliminare un elemento è sufficiente scorrere lo stesso verso sinistra. Infine è possibile effettuare un ricerca delle ricette secondo gli elementi inseriti.\n', style: TextStyle(color: Colors.black, fontSize: 18)),
                                TextSpan(text:'Lista Spesa\n',style: TextStyle(color: Colors.red, fontSize: 24)),
                                TextSpan(text:'Consiste di un\'effettiva lista della spesa: se, una volta visionata una ricetta, l\'utente dovesse rendersi conto di non avere un ingrediente potrà andarlo ad aggiungere in questa area. Anche in questo caso, per eliminare un elemento sarà sufficiente scorrere lo stesso verso sinistra.\n',style: TextStyle(color: Colors.black, fontSize: 18)),
                                TextSpan(text:'Tue Ricette\n',  style: TextStyle(color: Colors.red,fontSize: 24)),
                                TextSpan(text:'\'Ricette Tue\' è una funzionalità disponibile solo per gli utenti che hanno effettuato la registrazione: permette di creare ricette personalizzate secondo i gusti e le idee dell\'utente\n',style: TextStyle(color: Colors.black, fontSize: 18)),
                                TextSpan(text:'Login\n',  style: TextStyle(color: Colors.red,fontSize: 24)),
                                TextSpan(text:'Questa sezione sarà visibile solo agli utenti che non hanno effettuato la registrazione. Consiste di una form simile a quella che si trova all\'avvio dell\'applicazione e permette di effettuare il login oppure di registrarsi.\n',style: TextStyle(color: Colors.black, fontSize: 18)),
                                TextSpan(text:'Offline\n',  style: TextStyle(color: Colors.red,fontSize: 24)),
                                TextSpan(text:'Possiamo accedere a questa sezione semplicemente cliccando sul pulsante offline presente nelle varie aree dell\'applicazione. Qui potremo visualizzare ed accedere alle ricette che abbiamo salvato in precedenza.\n',style: TextStyle(color: Colors.black, fontSize: 18)),
                                TextSpan(text:'Ispirami\n',  style: TextStyle(color: Colors.red,fontSize: 24)),
                                TextSpan(text:'Non sai cosa cucinare? Pur di non pensare accetteresti un piatto a base di frattaglie di cavallo? Questa è la funzione che fa per te. \'Ispierami\' genera per te una ricetta casuale dal nostro database, a tuo rischio e pericolo :)\n',style: TextStyle(color: Colors.black, fontSize: 18)),
                                TextSpan(text:'Contattaci\n',  style: TextStyle(color: Colors.red,fontSize: 24)),
                                TextSpan(text:'Se hai domande puoi inviarci una mail. Se invece sei interessato ad ulteriori ricette puoi trovarci su instagram, dove le nostre esperte sono pronte a deliziarti con fantastici piatti!\n',style: TextStyle(color: Colors.black, fontSize: 18)),
                              ],
                            ),
                          ),
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
        child:Column(

        children:[
            GestureDetector(
            // When the child is tapped, show a snackbar.
            onTap: () async {
      var url = 'https://www.instagram.com/mela_magno/';

      if (await canLaunch(url)) {
      await launch(url, universalLinksOnly: true,);
      } else {
      throw 'There was a problem to open the url: $url';
      }},
          child:Container(
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

            child:Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "Mela Magno", style:TextStyle(color: Colors.black)),
            ),
            ),
          ),
            ),
    GestureDetector(
    // When the child is tapped, show a snackbar.
    onTap: () async {
      var url = 'https://www.instagram.com/ricette_a_8bit/';

    if (await canLaunch(url)) {
    await launch(url, universalLinksOnly: true,);
    } else {
    throw 'There was a problem to open the url: $url';
    }},
      child:Container(
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

      child:Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
      "Ricette a 8 bit", style:TextStyle(color: Colors.black)),
    ),
    ),
    ),
    ),
      Container(
          margin: const EdgeInsets.all(16),
      child: CupertinoButton.filled(child: Text('Mandaci una E-mail'),onPressed: () async {
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
      },)
      ), ]
      ),
      ),
      )
      );

  }
}
class MailClientOpenErrorDialog extends StatelessWidget {
  final String url;

  const MailClientOpenErrorDialog({Key? key, required this.url})
      : assert(url != ''),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Launch Error'),
      content: Text('We could not launch the following url:\n$url'),
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
