import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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