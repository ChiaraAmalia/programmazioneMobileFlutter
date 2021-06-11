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
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
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
