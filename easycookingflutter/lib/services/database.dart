import 'package:cloud_firestore/cloud_firestore.dart';

/*
Questa classe permette di salvare l'uid, il nome e il cognome dell'utente su FirebaseFirestore
 */

class DatabaseService {

  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference easyCookingCollection = Firestore.instance.collection('utenti');

  Future updateUserData(String nome, String cognome) async {
    return await easyCookingCollection.document(uid).setData({
      'nome': nome,
      'cognome': cognome,
    });
  }
}