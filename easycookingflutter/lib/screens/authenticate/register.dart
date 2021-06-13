import 'package:easycookingflutter/services/auth.dart';
import 'package:flutter/material.dart';

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
                        validator: (val) => val!.isEmpty ? 'Inserisci il tuo nome' : null,
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
                        validator: (val) => val!.isEmpty ? 'Inserisci il tuo cognome' : null,
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
                        validator: (val) => val!.isEmpty ? 'Inserisci la tua e-mail' : null,
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
                        validator: (val) => val!.length < 6 ? 'Inserisci una password più lunga di 6 caratteri' : null,
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
