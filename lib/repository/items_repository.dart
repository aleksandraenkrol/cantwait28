import 'package:cloud_firestore/cloud_firestore.dart';

import '../features/models/item.model.dart';

class ItemsRepository {
  Stream<List<ItemModel>> getItemsStream() {
    return FirebaseFirestore.instance
        .collection('items')
        .orderBy('release_date')
        .snapshots()
        .map(
      (querySnapshot) {
        return querySnapshot.docs.map(
          (doc) {
            return ItemModel(
              id: doc.id,
              title: doc['title'],
              imageURL: doc['image_url'],
              releaseDate: (doc['release_date'] as Timestamp).toDate(),
            );
          },
        ).toList();
      },
    );
  }
}
