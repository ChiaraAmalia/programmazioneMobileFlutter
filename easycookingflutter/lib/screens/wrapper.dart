import 'package:easycookingflutter/Model/user.dart';
import 'package:easycookingflutter/RicetteCerca.dart';
import 'package:easycookingflutter/RicetteCercaNoLogin.dart';
import 'package:easycookingflutter/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
/*
Classe che mostra, a seconda del fatto che l'utente si sia autenticato o meno,
la relativa schermata iniziale
 */
class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User?>(context);

    if(user == null){
      return RicetteCercaNoLogin(title: 'Easy Cooking');
    }
    else {
      return RicetteCerca(title: 'Easy Cooking');
    }
  }
}
