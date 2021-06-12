import 'package:easycookingflutter/RicetteCerca.dart';
import 'package:flutter/material.dart';
import 'package:easycookingflutter/services/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  final Function toggleView;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  //text field state
  String email = '';
  String password = '';
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
                WidgetSpan(
                    child: SizedBox(
                      child:  Image.asset(
                        "assets/images/frigologo.png",
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                    )),
                TextSpan(text:'\nAccedi o Registrati\n', style: TextStyle(color: Colors.red,fontSize: 24, height: 2.3)),], ),),),

           Form(
          child: Column(
            children: <Widget>[
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
                onChanged: (val) {
                  setState(() => password = val);
                }
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.red,
                child: Text(
                  'Accedi',
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
              widget.toggleView();
            },
          )
        ],
    ),
      )
    );
  }
}
