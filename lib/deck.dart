class Deck {
  final String id;
  final String name;
  final String type;
  final String desc;
  final String race;
  final String archetype;
  var card_sets = [];
  var card_images = [];
  var card_prices = {};

  Deck({
    this.id,
    this.name,
    this.type,
    this.desc,
    this.race,
    this.archetype,
    this.card_sets,
    this.card_images,
    this.card_prices
  });
}
