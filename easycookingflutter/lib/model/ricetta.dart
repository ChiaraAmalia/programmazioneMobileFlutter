/*
Classe che descrive una ricetta, verrà usata, per "trasformare" in oggetti i dati scaricati da Firebase
 */
class Ricetta{
 List<Object> ingredienti, intolleranze, quantita, unita;
  String cookTime, descrizione, image, nome, porzioni, prepTime, preparazione, recipeCategory, recipeCuisine, totalTime;
  bool vegano;
/*
Costruttore della classe
 */
  Ricetta(
      this.cookTime,
      this.descrizione,
      this.image,
      this.ingredienti,
      this.intolleranze,
      this.nome,
      this.porzioni,
      this.preparazione,
      this.prepTime,
      this.quantita,
      this.recipeCategory,
      this.recipeCuisine,
      this.totalTime,
      this.unita,
      this.vegano
      );


}

