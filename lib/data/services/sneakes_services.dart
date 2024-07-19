import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shoe_project/data/services/category_model.dart';
import 'sneakers_model.dart';

class SneakesServices {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> addToBook() async {
    await db
        .collection('Book')
        // .withConverter(fromFirestore: fromFirestore, toFirestore: toFirestore)
        .add({
          "name": 'Gamers',
        })
        .then((value) => print("collection id is set"))
        .onError((e, _) => print('Error writing document: $e'));
  }

  Future<void> addSneaker() async {
    await db
        .collection('Sneaker')
        // .withConverter(fromFirestore: fromFirestore, toFirestore: toFirestore)
        .add({
          "name": 'Gamers',
        })
        .then((value) => print("collection id is set"))
        .onError((e, _) => print('Error writing document: $e'));
  }

  Future<void> updateBook() async {
    await db
        .collection('Book')
        .doc("Harrypotter")
        .update({"name": 'Gamers', "id": "Harrypotter"})
        .then((value) => print("collection id is set"))
        .onError((e, _) => print('Error writing document: $e'));
  }
  // Update one field, creating the document if it does not already exist.
  // final data = {"capital": true};

// db.collection("cities").doc("BJ").set(data, SetOptions(merge: true));

  Future<void> getData() async {
    db.collection("Book").doc("Harrypotter").get().then(
      (querySnapshot) {
        print("Successfully completed");
        print("${querySnapshot.data()}");
        // for (var docSnapshot in querySnapshot.docs) {
        //   print('${docSnapshot.id} => ${docSnapshot.data()}');
        // }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  Future<List> getDataAll() async {
    try {
      var allBooks = await db
          .collection("Category")
          .withConverter(
              fromFirestore: CategoryModel.fromFirestore,
              toFirestore: (CategoryModel category, _) =>
                  category.toFirestore())
          .get();

      return allBooks.docs;
    } catch (e) {
      throw Exception("Error Occured");
    }
  }

  Future<String> addSneakers(SneakersModel neaker) async {
    try {
      var sneakers = await db
          .collection("Sneakers")
          .withConverter(
              fromFirestore: SneakersModel.fromFirestore,
              toFirestore: (SneakersModel sneakers, _) =>
                  sneakers.toFirestore())
          .add(neaker);

      return sneakers.id;
    } catch (e) {
      throw Exception("Error Occured");
    }
  }

  Future<void> addCategory(CategoryModel neaker) async {
    try {
      var sneakers = await db
          .collection("Category")
          .doc(neaker.id)
          .withConverter(
              fromFirestore: CategoryModel.fromFirestore,
              toFirestore: (CategoryModel category, _) =>
                  category.toFirestore())
          .set(neaker);
    } catch (e) {
      throw Exception("Error Occured");
    }
  }

  Future<QuerySnapshot<CategoryModel>> getAllCategory() async {
    try {
      var sneakers = await db
          .collection("Category")
          .withConverter(
              fromFirestore: CategoryModel.fromFirestore,
              toFirestore: (CategoryModel category, _) =>
                  category.toFirestore())
          .get();
      return sneakers;
    } catch (e) {
      throw Exception("Error Occured");
    }
  }
}

Future<void> addCategory() async {}
