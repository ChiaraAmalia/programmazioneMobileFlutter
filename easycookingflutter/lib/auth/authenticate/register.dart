import 'package:easycookingflutter/services/auth.dart';
import 'package:flutter/material.dart';
/*
Classe che permette all'utente di registrasi e valida i dati da esso inseriti
I validator vengono poi utilizzati per effettuare i test
 */
class NomeFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? 'Nome non può essere vuoto' : null;
  }
}

class CognomeFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? 'Cognome non può essere vuoto' : null;
  }
}

class EmailFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? 'Email non può essere vuoto' : null;
  }
}

class PasswordFieldValidator {
  static String? validate(String value) {
    return value.length < 6 ? 'Inserisci una password più lunga di 6 caratteri' : null;
  }
}

class Register extends StatefulWidget {
  const Register({Key? key, required this.toggleView}) : super(key: key);

  final Function toggleView;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String nome = '';
  String cognome = '';
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child:Column(
            children:[
              Align(
                alignment: Alignment.center,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text:'',
                    style: TextStyle(color: Colors.red, fontSize:1,),
                    children: <InlineSpan>[
                      TextSpan(text:'\nRegistrati\n', style: TextStyle(color: Colors.red,fontSize: 24, height: 2.3)),], ),),),

              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Align(
                      alignment: Alignment.topLeft,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text:'',
                          style: TextStyle(color: Colors.red, fontSize:1),
                          children: <InlineSpan>[
                            TextSpan(text:'\nNome:\n', style: TextStyle(color: Colors.red,fontSize: 15, height: 1)),], ),),),
                    TextFormField(
                        validator: (val) => NomeFieldValidator.validate(val!),
                        onChanged: (val) {
                          setState(() => nome = val);
                        }
                    ),
                    SizedBox(height: 20.0),
                    Align(
                      alignment: Alignment.topLeft,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text:'',
                          style: TextStyle(color: Colors.red, fontSize:1,),
                          children: <InlineSpan>[
                            TextSpan(text:'\nCognome:\n', style: TextStyle(color: Colors.red,fontSize: 15, height: 1)),], ),),),
                    TextFormField(
                        validator: (val) => CognomeFieldValidator.validate(val!),
                        onChanged: (val) {
                          setState(() => cognome = val);
                        }
                    ),
                    SizedBox(height: 20.0),
                    Align(
                      alignment: Alignment.topLeft,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text:'',
                          style: TextStyle(color: Colors.red, fontSize:1,),
                          children: <InlineSpan>[
                            TextSpan(text:'\nEmail:\n', style: TextStyle(color: Colors.red,fontSize: 15, height: 1)),], ),),),
                    TextFormField(
                        validator: (val) => EmailFieldValidator.validate(val!),
                        onChanged: (val) {
                          setState(() => email = val);
                        }
                    ),
                    SizedBox(height: 20.0),
                    Align(
                      alignment: Alignment.topLeft,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text:'',
                          style: TextStyle(color: Colors.red, fontSize:1,),
                          children: <InlineSpan>[
                            TextSpan(text:'\nPassword:\n', style: TextStyle(color: Colors.red,fontSize: 15, height: 1)),], ),),),
                    TextFormField(
                        obscureText: true,
                        validator: (val) =>  PasswordFieldValidator.validate(val!),
                        onChanged: (val) {
                          setState(() => password = val);
                        }
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Colors.red,
                      child: Text(
                        'Registrati',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                          if(_formKey.currentState!.validate()) {
                            dynamic result = await _auth.registerWithEmailAndPassword(nome, cognome, email, password);
                            if(result == null){
                              setState(() => error = 'Inserisci un indirizzo email valido');
                            }
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Registrazione effettuata con successo"),
                            ));
                          }
                      },
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),

              RaisedButton(
                color: Colors.red,
                child: Text(
                  'Accedi',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  widget.toggleView();
                },
              )
            ],
          ),
        )
    );
  }
}
