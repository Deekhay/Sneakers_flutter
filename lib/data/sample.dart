import 'package:cloud_firestore/cloud_firestore.dart';

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
  final List<Sneakers>? sneakers;

  Category({required this.id, required this.name, required this.sneakers});

  factory Category.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Category(
      name: data?['name'],
      id: data?['id'],
      sneakers:
          data?['sneakers'] is Iterable ? List.from(data?['sneakers']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (id != null) "id": id,
      if (sneakers != null) "sneakers": sneakers,
    };
  }
}
