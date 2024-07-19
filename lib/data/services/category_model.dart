import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoe_project/data/sample.dart';

class CategoryModel {
  final String? id;

  CategoryModel({required this.id});

  factory CategoryModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return CategoryModel(
      id: data?['id'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
    };
  }
}
