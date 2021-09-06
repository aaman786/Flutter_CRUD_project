import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  FirebaseFirestore? firestore;
  initialise() {
    firestore = FirebaseFirestore.instance;
  }

// write the create method

  Future<List> read() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot =
          await firestore!.collection("board").orderBy("timestamp").get();
      // print("The length ${querySnapshot.docs.length}");
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {
            "id": doc.id,
            "name": doc['name'],
            "code": doc['id'],
          };
          docs.add(a);
        }
        print(docs);
      }
    } catch (e) {
      print("The exception is " + e.toString());
    }
    return docs;
  }

  Future<void> update(String id, String name, String code) async {
    try {
      await firestore!
          .collection("board")
          .doc(id)
          .update({'name': name, 'code': code});
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> add(String name, String code) async {
    try {
      await firestore!.collection("board").add({
        'name': name,
        'id': code, //name we want as same for all in db
        'timestamp': FieldValue.serverTimestamp()
      });
      print(name);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> delet(String id) async {
    try {
      await firestore!.collection("board").doc(id).delete();
      print(id);
    } catch (e) {
      print(e.toString());
    }
  }
}
