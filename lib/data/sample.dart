class Sneakers {
  final String id;
  final String name;
  final int price;
  final String description;
  final List<String> images;
  final bool hasDiscount;
  final int discountPercentage;

  Sneakers(
    this.id,
    this.images,
    this.hasDiscount,
    this.discountPercentage, {
    required this.name,
    required this.price,
    required this.description,
  });
}

class Category {
  final String id;
  final String name;
  final List<Sneakers> sneakers;

  Category({required this.id, required this.name, required this.sneakers});
}
