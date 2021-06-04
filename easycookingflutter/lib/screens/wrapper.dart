import 'package:easycookingflutter/screens/authenticate/authenticate.dart';
import 'package:easycookingflutter/screens/home/home.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //return either or Authenticate widget
    return Authenticate();
  }
}
