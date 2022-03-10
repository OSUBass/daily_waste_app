import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  //collection reference
  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection('posts');


//adds new pet and captures pet id from add pet form
  Future addPost(String wastePic, int wasteNum, String wasteLat, String wasteLong) async {
    return await postCollection.add({
      'wastePic': wastePic,
      'wasteNum': wasteNum,
      'wasteDate': FieldValue.serverTimestamp(),
      'wasteLat': wasteLat,
      'wasteLong': wasteLong,
    }).then((value) {
      return value.id;
    });
  }
}