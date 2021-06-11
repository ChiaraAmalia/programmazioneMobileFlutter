import 'package:easycookingflutter/RicetteCerca.dart';
import 'package:flutter/material.dart';
import 'package:easycookingflutter/services/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        elevation: 0.0,
        title: Text('EasyCooking')
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: RaisedButton(
          child: Text('Continua senza registrarti'),
          onPressed: () async{
            dynamic result = await _auth.signInAnon();
            if(result == null) {
              print('errore durante il sign-in');
            }else{
              print('sign-in effettuato con successo');
              print(result.uid);
            }
          },
        ),
      )
    );
  }
}
