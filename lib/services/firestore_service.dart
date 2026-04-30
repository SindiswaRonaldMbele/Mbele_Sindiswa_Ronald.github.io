import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/portfolio_item.dart';

class FirestoreService {
  FirestoreService(this.collectionName);
  final String collectionName;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get collection => firestore.collection(collectionName);

  Stream<List<PortfolioItem>> watchItems() => collection.snapshots().map((snapshot) {
        final items = snapshot.docs.map((doc) => PortfolioItem.fromMap(doc.id, doc.data())).toList();
        items.sort((a, b) => a.title.compareTo(b.title));
        return items;
      });

  Future<void> saveItem(PortfolioItem item) {
    final doc = item.id.isEmpty ? collection.doc() : collection.doc(item.id);
    return doc.set(item.toMap());
  }

  Future<void> deleteItem(String id) => collection.doc(id).delete();
}
