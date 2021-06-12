import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/models/food.dart';

class Firestore {
  CollectionReference food = FirebaseFirestore.instance.collection('food');

  Stream<List<Food>> getFoodList() => food.snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Food.fromFirestore(doc)).toList(),
      );

  Future<String> addFood(Food foods) async {
    try {
      await food.add(foods.toFirestore());
      return 'ok';
    } catch (error) {
      print(error);
      return error.toString();
    }
  }

  Future<String> updateFood(String id, Food foods) async {
    try {
      await food.doc(id).set(foods.toFirestore(), SetOptions(merge: true));
      return 'ok';
    } catch (error) {
      print(error);
      return error.toString();
    }
  }

  Future<String> removeFood(String id) async {
    try {
      await food.doc(id).delete();
      return 'ok';
    } catch (error) {
      print(error);
      return error.toString();
    }
  }
}
