import 'package:easycookingflutter/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                        onChanged: (val) {
                          setState(() => email = val);
                        }
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                        obscureText: true,
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
                        print(email);
                        print(password);
                      },
                    )
                  ],
                ),
              ),

              RaisedButton(
                color: Colors.red,
                child: Text(
                  'Registrati',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {

                },
              )
            ],
          ),
        )
    );
  }
}
