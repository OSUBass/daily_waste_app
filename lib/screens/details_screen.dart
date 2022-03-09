import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:wasteagram/screens/list_screen.dart';
import 'package:wasteagram/models/post_model.dart';

class Details extends StatelessWidget {
  final Post details;
  
  const Details({ Key? key, required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Column(
        children: [
          Text('pic is ${details.wastePic}'),
          Text('num wasted is ${details.wasteNum}'),
          Text('date is ${details.wasteDate}'),
          Text('long is ${details.wasteLong}'),
          Text('lat is ${details.wasteLat}'),
        ],
      ),
    );
  }
}