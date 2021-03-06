import '../../pages/RicetteCerca.dart';
import 'package:easycookingflutter/auth/authenticate/ResetPassword.dart';
import 'package:flutter/material.dart';
import 'package:easycookingflutter/services/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/*
Classe che permette all'utente già registrato di effettuare il LOGIN
I validator vengono poi utilizzati per effettuare i test
 */

class EmailValidator {
  static String? validate(String value) {
    return value.isEmpty ? 'Email non può essere vuoto' : null;
  }
}

class PasswordValidator {
  static String? validate(String value) {
    return value.length < 6 ? 'Inserisci una password più lunga di 6 caratteri' : null;
  }
}

class SignIn extends StatefulWidget {
  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  final Function toggleView;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';
  String error = '';
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
                        fit: BoxFit.cover,
                      ),
                    )),
                TextSpan(text:'\nAccedi o Registrati\n', style: TextStyle(color: Colors.red,fontSize: 24, height: 2.3)),], ),),),

           Form(
             key: _formKey,
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
                validator: (val) => EmailValidator.validate(val!),
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
                validator: (val) => PasswordValidator.validate(val!),
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
                  if(_formKey.currentState!.validate()) {
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() => error = 'Indirizzo email o password non validi');
                    }
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Login effettuato con successo"),
                    ));
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
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
          ),

          TextButton(
            child: Text('Password dimenticata?'),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResetScreen()))
          )

        ],
    ),

      )
    );
  }
}
