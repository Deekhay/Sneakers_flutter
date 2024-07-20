import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shoe_project/data/model/category_model.dart';
import 'package:shoe_project/data/services/upload_services.dart';
import '../model/sneakers_model.dart';

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

  Future<void> getData() async {
    db.collection("Book").doc("Harrypotter").get().then(
      (querySnapshot) {
        print("Successfully completed");
        print("${querySnapshot.data()}");
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

  Future<String> addSneakersWithImage(
      SneakersModel neaker, filePath, fileName) async {
    print(filePath);
    try {
      var downloadurl = await UpLoadService()
          .upLoadFile(filePath, fileName, neaker.catergory!);

      print(downloadurl);
      neaker.images?.add(downloadurl);
      var sneakers = await db
          .collection("Sneakers")
          .withConverter(
              fromFirestore: SneakersModel.fromFirestore,
              toFirestore: (SneakersModel sneakers, _) =>
                  sneakers.toFirestore())
          .add(neaker);
      print((await sneakers.get()).data());
      return sneakers.id;
    } catch (e) {
      throw Exception(e);
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
