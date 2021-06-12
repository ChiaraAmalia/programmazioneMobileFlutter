import 'package:easycookingflutter/screens/authenticate/register.dart';
import 'package:flutter/material.dart';
import 'package:easycookingflutter/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  @override
  Widget build(BuildContext context) {
      if(showSignIn){
        return SignIn();
      } else {
        return Register();
      }
  }
}
