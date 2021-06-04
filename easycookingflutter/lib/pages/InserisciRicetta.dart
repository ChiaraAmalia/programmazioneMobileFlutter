
import 'dart:io';

import 'package:easycookingflutter/Model/RicettaInserimento.dart';
import 'package:easycookingflutter/MyFlutterApp.dart';
import 'package:easycookingflutter/Model/Prodotto.dart';
import 'package:easycookingflutter/services/DatabaseHandler.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class InserisciRicetta extends StatefulWidget{
  InserisciRicetta({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  _InserisciRicettaState createState() => _InserisciRicettaState();
}

class _InserisciRicettaState extends State<InserisciRicetta> {

//DATABASE
  late DatabaseHandler handler;

  @override
  void initState() {
    super.initState();
    this.handler = DatabaseHandler();
    this.handler.initializeDB();
  }

//DATABASE
  TextEditingController _textFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  File? _image;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:Center(
        child: Form(
          key: this._formKey,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Insrisci la tua ricetta'),
                GestureDetector(
                  onTap: () {
                    _showPicker(context);
                  },
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Color(0xffFDCF09),
                    child: _image != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        _image!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.fitHeight,
                      ),
                    )
                        : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50)),
                      width: 100,
                      height: 100,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ),
                Text('Nome Ricetta: '),
                TextFormField(
                  onSaved: (value) => this.valueNome = value!,
                ),
                Text('Tempo di cottura: '),
                TextFormField(
                  onSaved: (value) => this.valueCook = value!,
                ),
                Text('Tempo preparazione: '),
                TextFormField(
                  onSaved: (value) => this.valuePrep = value!,
                ),
                Text('Porzioni: '),
                TextFormField(
                  onSaved: (value) => this.valuePorz = value!,
                ),
                Text('Procedimento: '),
                TextFormField(
                  onSaved: (value) => this.valuePrepa = value!,
                ),
                Text('Ingredienti: '),
                TextFormField(
                  onSaved: (value) => this.Ingre = value!,
                ),
                RaisedButton(
                  child: Text('Salva Ricetta'),
                  onPressed: () {
                      setState(() {
                        this._formKey.currentState!.save();
                        RicettaInserimento ric = RicettaInserimento(nome_ricetta: valueNome, ingredienti_ricetta: Ingre, cookTime: valueCook, prepTime: valuePrep, totalTime: "totalTime", fotoRicetta: _image!.readAsBytesSync(), porzioni: valuePorz, preparazione: valuePrepa);
                        this.handler.inserisciUnaRicetta(ric);
                        Navigator.pop(context);
                      });
                    }
                ),
              ],
            ),
          ),
        ),
      ),
      ),


    );

  }
  late String valueNome;
  late String valueCook;
  late String valuePrep;
  late String valuePorz;
  late String valuePrepa;
  //late String valueAppoggio;
  late String Ingre;
  //late List<String> valueIngr;
  //per la foto
  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );
        setState(() {
      _image = image;
    });

  }


  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );
    setState(() {
      _image = image;
    });

  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Galleria'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Fotocamera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
