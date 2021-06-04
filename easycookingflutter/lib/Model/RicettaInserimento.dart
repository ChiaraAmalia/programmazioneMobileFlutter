import 'package:flutter/cupertino.dart';

class RicettaInserimento {

  final String nome_ricetta;
  final String ingredienti_ricetta;
  final String cookTime;
  final String prepTime;
  final String totalTime;
  final String fotoRicetta;
  final String porzioni;
  final String preparazione;


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