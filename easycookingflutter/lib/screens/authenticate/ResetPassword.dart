

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
/*
Classe che permette all'utente già registrato di
settare una nuova password nel caso si fosse dimenticato
quella precedente
 */
class ResetScreen extends StatefulWidget {

  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {

  late String _email;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password')
      ),
      body: Column(
        children: [
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
          onChanged: (val) {
            setState(() => _email = val);
          }),

        SizedBox(height: 20.0),
          RaisedButton(
            color: Colors.red,
            child: Text(
              'Reset password',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              auth.sendPasswordResetEmail(email: _email);
              Navigator.of(context).pop();
            },
          ),
        ],
      )
    );
  }
}
