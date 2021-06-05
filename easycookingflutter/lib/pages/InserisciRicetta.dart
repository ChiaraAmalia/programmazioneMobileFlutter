
import 'dart:io';

import 'package:easycookingflutter/Model/RicettaInserimento.dart';
import 'package:easycookingflutter/MyFlutterApp.dart';
import 'package:easycookingflutter/Model/Prodotto.dart';
import 'package:easycookingflutter/services/DatabaseHandler.dart';
import 'package:flutter/cupertino.dart';
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
  static List<String?> ingredientiList = [null];
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
              CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hms,
                minuteInterval: 1,
                secondInterval: 1,
                onTimerDurationChanged: (Duration changedtimer) {
                  setState(() {
                    this.valueCook = changedtimer;
                  });
                },
              ),
                Text('Tempo preparazione: '),
                CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.hms,
                  minuteInterval: 1,
                  secondInterval: 1,
                  onTimerDurationChanged: (Duration changedtimer) {
                    setState(() {
                      this.valuePrep = changedtimer;
                    });
                  },
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
                ..._getIngredienti(),
                /*TextFormField(
                  onSaved: (value) => this.Ingre = value!,
                ),*/
                RaisedButton(
                  child: Text('Salva Ricetta'),
                  onPressed: () {
                      setState(() {
                        this._formKey.currentState!.save();
                        String Ingredi="";
                        ingredientiList.forEach((ing) { Ingredi+=ing!+'\n'; });
                        String cot= valueCook.toString();
                        String cottura = cot.substring(0, cot.indexOf('.'));
                        String prepa = valuePrep.toString();
                        String preparazione = prepa.substring(0, prepa.indexOf('.'));
                        Duration valueTot = valueCook+valuePrep;
                        String tot = valueTot.toString();
                        String totale = tot.substring(0, tot.indexOf('.'));



                        RicettaInserimento ric = RicettaInserimento(nome_ricetta: valueNome, ingredienti_ricetta: Ingredi, cookTime: cottura, prepTime: preparazione, totalTime: totale, fotoRicetta: _image!.readAsBytesSync(), porzioni: valuePorz, preparazione: valuePrepa);
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
  late Duration valueCook;
  late Duration valuePrep;
  late String valuePorz;
  late String valuePrepa;
  //late String valueAppoggio;
  //late String Ingre;
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


  List<Widget> _getIngredienti(){
    List<Widget> ingredientiTextFieldsList = [];
    for(int i=0; i<ingredientiList.length; i++){
      ingredientiTextFieldsList.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                Expanded(child: IngredienteTextFields(i)),
                SizedBox(width: 16,),
                // we need add button at last friends row only
                _addRemoveButton(i == ingredientiList.length-1, i),
              ],
            ),
          )
      );
    }
    return ingredientiTextFieldsList;
  }
  Widget _addRemoveButton(bool add, int index){
    return InkWell(
      onTap: (){
        if(add){
          // add new text-fields at the top of all friends textfields
          ingredientiList.insert(0, null);
        }
        else ingredientiList.removeAt(index);
        setState((){});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove, color: Colors.white,
        ),
      ),
    );
  }

}
class IngredienteTextFields extends StatefulWidget {
  late final int index;
  IngredienteTextFields(this.index);
  @override
  _IngredienteTextFieldsState createState() => _IngredienteTextFieldsState();
}
class _IngredienteTextFieldsState extends State<IngredienteTextFields> {
  late TextEditingController _nameController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _nameController.text = _InserisciRicettaState.ingredientiList[widget.index]
          ?? '';
    });
    return TextFormField(
      controller: _nameController,
      // save text field data in friends list at index
      // whenever text field value changes
      onChanged: (v) => _InserisciRicettaState.ingredientiList[widget.index] = v,
      decoration: InputDecoration(
          hintText: 'Inserisci Ingrediente'
      ),
      validator: (v){
        if(v!.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}
