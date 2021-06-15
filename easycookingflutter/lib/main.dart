import 'package:easycookingflutter/Model/user.dart';
import 'package:easycookingflutter/pages/Contattaci.dart';
import 'package:easycookingflutter/pages/Dispensa.dart';
import 'package:easycookingflutter/pages/InserisciRicetta.dart';
import 'package:easycookingflutter/pages/Ispirami.dart';
import 'package:easycookingflutter/pages/Logout.dart';
import 'package:easycookingflutter/pages/RicetteCercaPage.dart';
import 'package:easycookingflutter/pages/RicetteTue.dart';
import 'package:easycookingflutter/pages/Spesa.dart';
import 'package:easycookingflutter/screens/wrapper.dart';
import 'package:easycookingflutter/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easycookingflutter/Model/user.dart';

void main() => runApp(MyApp());
/*
Schermata di partenza della nostra APP, nella quale si effettua il login/ la registrazione o si procede in maniera anonima
 */

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //the widget is the root of the application
    return StreamProvider<User?>.value(
      value: AuthService().user,
        initialData: null,
        child: MaterialApp(
        home: Wrapper(),
          title: 'Easy Cooking',
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.red,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.red,
          ),
          themeMode: ThemeMode.system,
          routes: {
            '/dispensa': (context) => Dispensa(),
            '/contattaci': (context) => Contattaci(title: 'Contattaci'),
            '/ispirami': (cintext) => Ispirami(),
            '/spesa': (context) => Spesa(),
            '/cerca':(context) => RicetteCercaPage(),
            '/ricetteTue':(context) => RicetteTue(),
            '/inserisciRicetta': (context) => InserisciRicetta(),
            '/logout': (context) => Logout(),
          },
        ),
    );

  }
}
