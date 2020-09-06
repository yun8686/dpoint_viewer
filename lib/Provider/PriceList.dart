import 'package:cloud_firestore/cloud_firestore.dart';

class PriceListProvider {
  static CollectionReference collection =
      FirebaseFirestore.instance.collection("price_list");

  static Future<bool> loadLatestPrice() async {
    QuerySnapshot ds = await collection.limit(1).get();
    print(ds.docs[0].data());
//    return result.docs();
  }
}
