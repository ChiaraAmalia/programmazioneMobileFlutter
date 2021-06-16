import 'dart:collection';

import 'package:easycookingflutter/Model/user.dart';
import 'package:easycookingflutter/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

/*
classe che contiene tutte le funzioni che permettono il signIn o la registrazione dell'utente
 */

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create a user obj based on FirebaseUser
  User? _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User?> get user {
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }

  //sign in con email & password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }

  }

  //registrazione email & password
  Future registerWithEmailAndPassword(String nome, String cognome, String email, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      //create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData(nome, cognome);

      return _userFromFirebaseUser(user);

    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }

}