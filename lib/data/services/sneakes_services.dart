import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class SneakesServices {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> addToBook() async {
    await db
        .collection('Book')
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

  Future<void> getDataAll() async {
    db.collection("Book").get().then(
      (querySnapshot) {
        print("Successfully completed");
        // print("${querySnapshot.data()}");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
}
