class Prodotto {
  final String nome_prodotto;

  Prodotto({
    required this.nome_prodotto,
});
  Prodotto.fromMap(Map<String, dynamic> res)
    : nome_prodotto = res["nome_prodotto"];

  Map<String, Object?> toMap(){
    return{'nome_prodotto': nome_prodotto};
  }
  }
