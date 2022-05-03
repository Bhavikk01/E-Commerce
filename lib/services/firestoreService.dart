import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/UserData.dart';
import '../models/order.dart';
import '../models/products.dart';

class FirestoreService{
  FirestoreService({required this.uid});
  final String uid;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addProduct(Product product) async {
    final docId = firestore.collection("products").doc().id;
    await firestore.collection("products").doc(docId).set(product.toMap(docId));
  }

  Future<void> deleteProducts(String id)async{
    return await firestore.collection("products").doc(id).delete();
  }

  Future<void> addUser(UserData user)async{
    await firestore.collection("users").doc(user.uid).set(user.toMap());
  }

  Future<UserData?> getUser(String uid) async {
    final doc = await firestore.collection("users").doc(uid).get();
    return doc.exists ? UserData.fromMap(doc.data()!) : null;
  }

  Stream<List<Product>> getProduct(){
    return firestore
        .collection("products")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
          final d = doc.data();
          return Product.fromMap(d);
    }).toList());
  }

  Stream<List<Order>> getOrders() {
    return firestore
        .collection("users")
        .doc(uid)
        .collection("orders")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
      final d = doc.data();
      return Order.fromMap(d);
    }).toList());
  }

}