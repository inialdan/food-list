import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  final String? id;
  final String title;
  final String detail;
  final String image;

  Food({
    this.id,
    required this.title,
    required this.detail,
    required this.image,
  });

  factory Food.fromFirestore(DocumentSnapshot snapshot) {
    return Food(
      id: snapshot.id,
      title: snapshot['title'],
      detail: snapshot['detail'],
      image: snapshot['image'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "title": title,
      'detail': detail,
      "image": image,
    };
  }
}
