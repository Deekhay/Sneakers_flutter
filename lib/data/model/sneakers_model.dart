import 'package:cloud_firestore/cloud_firestore.dart';

class SneakersModel {
  final String? name;
  final int? price;
  final String? description;
  final List<String>? images;
  final bool? hasDiscount;
  final int? discountPercentage;
  final String? catergory;

  SneakersModel({
    this.catergory,
    this.images,
    this.hasDiscount,
    this.discountPercentage,
    this.name,
    this.price,
    this.description,
  });

  factory SneakersModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return SneakersModel(
        catergory: data?['category'],
        images: data?['images'],
        hasDiscount: data?['hasDiscount'],
        name: data?['name'],
        price: data?['price'],
        description: data?['description']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (images != null) "images": images,
      if (hasDiscount != null) "hasDiscount": hasDiscount,
      if (price != null) "price": price,
      if (description != null) "descriptio": description,
      if (catergory != null) "category": catergory
    };
  }
}
