import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

/*
Classe che descrive una ricetta scritta dall'utente (personale), verrà usata per permettere di salvare, eliminare e visualizzare le
ricette nel DB
 */
class RicettaInserimento {

  final String nome_ricetta;
  final String ingredienti_ricetta;
  final String cookTime;
  final String prepTime;
  final String totalTime;
  final Uint8List fotoRicetta;
  final String porzioni;
  final String preparazione;

/*
Costruttore della classe
 */
  RicettaInserimento({
    required this.nome_ricetta,
    required this.ingredienti_ricetta,
    required this.cookTime,
    required this.prepTime,
    required this.totalTime,
    required this.fotoRicetta,
    required this.porzioni,
    required this.preparazione
  });
  /*
  Funzione che permette di mappare l'oggetto RicettaInserimento, per permettere le interazioni con il DB
   */
  RicettaInserimento.fromMap(Map<String, dynamic> res)
      : nome_ricetta = res["nome_ricetta"],
        ingredienti_ricetta = res["ingredienti_ricetta"],
        cookTime = res["cookTime"],
        prepTime = res["prepTime"],
        totalTime = res["totalTime"],
        fotoRicetta = res["fotoRicetta"],
        porzioni = res["porzioni"],
        preparazione = res["preparazione"];

  Map<String, Object?> toMap(){
    return{'nome_ricetta': nome_ricetta,'ingredienti_ricetta' : ingredienti_ricetta, 'cookTime' : cookTime,
      'prepTime': prepTime, 'totalTime':totalTime,'fotoRicetta': fotoRicetta, 'porzioni':porzioni, 'preparazione': preparazione};
  }
}