/*
Classe che descrive un prodotto, verrà usata per salvare, eliminare e visualizzare nel database sia i prodotti da comprare
(Lista della Spesa), sia i prodotti presenti in dispensa (Dispensa)
 */
class Prodotto {

  final String nome_prodotto;
/*
Costruttore della classe
 */
  Prodotto({
    required this.nome_prodotto
});
  /*
  Funzione che permette di mappare l'oggetto Prodotto, per permettere le interazioni con il DB
   */
  Prodotto.fromMap(Map<String, dynamic> res)
    : nome_prodotto = res["nome_prodotto"];

  Map<String, Object?> toMap(){
    return{'nome_prodotto': nome_prodotto};
  }
  }
