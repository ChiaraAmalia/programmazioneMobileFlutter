class Ricetta{
 List<Object> ingredienti, intolleranze,/* keywords,*/ quantita, unita;
  String cookTime, descrizione, image, nome, porzioni, prepTime, preparazione, recipeCategory, recipeCuisine, totalTime;
  bool vegano;

  Ricetta(
      this.cookTime,
      this.descrizione,
      this.image,
      this.ingredienti,
      this.intolleranze,/* this.keywords,*/
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

// ignore: empty_constructor_bodies
}

