import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easycookingflutter/MyFlutterApp.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

import 'RicetteTue.dart';


class RicetteTueDettaglio extends StatefulWidget {
  RicetteTueDettaglio({Key? key}) : super(key: key);

  @override
  _RicetteTueDettaglioState createState() => _RicetteTueDettaglioState();
}

class _RicetteTueDettaglioState extends State<RicetteTueDettaglio> {

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as RicettaDettaglioArgomenti;

    return Scaffold(
      body: SingleChildScrollView(
          child:Column(
            children: [
              //foto con titolo
              Container(
                margin: const EdgeInsets.all(16),
                decoration: ShapeDecoration(
                    color: Colors.orange[50],
                    image: DecorationImage(
                        image: AssetImage("assets/images/mela.JPG"),
                        fit: BoxFit.cover),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(20))),
                width: 350,
                height: 400,

                child:Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        args.nome_ricetta, style:TextStyle(color: Colors.white,fontSize: 30)),
                  ),
                ),
              ),
      //tabella con tempi
      DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Preparazione:',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Cottura:',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Totale:',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
        rows: <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(Text(args.prepTime)),
              DataCell(Text(args.cookTime)),
              DataCell(Text(args.totalTime)),
            ],
          ),
        ],
      ),
              Text("Ingredienti:", style: TextStyle(color: Colors.red,fontSize: 24, fontStyle: FontStyle.italic)),
              Text(args.ingredienti_ricetta),
              Text("Procedimento:", style: TextStyle(color: Colors.red,fontSize: 24, fontStyle: FontStyle.italic)),
              Text(args.preparazione),
            ],
          )
      ),
    );
  }
}