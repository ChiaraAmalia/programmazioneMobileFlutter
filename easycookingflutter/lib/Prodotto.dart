class Prodotto {
  final int? id;
  final String nome_prodotto;

  Prodotto({ this.id,
    required this.nome_prodotto
});
  Prodotto.fromMap(Map<String, dynamic> res)
    : id = res["id"],
      nome_prodotto = res["nome_prodotto"];

  Map<String, Object?> toMap(){
    return{'id':id,'nome_prodotto': nome_prodotto};
  }
  }
