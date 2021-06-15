import 'package:easycookingflutter/auth/authenticate/register.dart';
import 'package:flutter/material.dart';
import 'package:easycookingflutter/auth/authenticate/sign_in.dart';
/*
Classe per la gestione dell'autenticazione
 */
class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  // gestisce lo swap tra l'interfaccia di signIn e registrazione
  @override
  Widget build(BuildContext context) {
      if(showSignIn){
        return SignIn(toggleView: toggleView);
      } else {
        return Register(toggleView: toggleView);
      }
  }
}
