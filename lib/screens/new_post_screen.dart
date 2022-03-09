import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wasteagram/services/db.dart';

class NewPost extends StatefulWidget {
  NewPost({ Key? key }) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final String wastePic = 'pic here'; 
  int wasteNum = 0; 
  final String wasteLat = '0'; 
  final String wasteLong= '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post')),
      body:Column(
        children: [
          Text('upload pic here'),
          TextField(
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Enter the number of wasted items',
            ),
            onChanged: (value) => setState(() => wasteNum = int.parse(value)),
          ),
          GestureDetector(
            child: const Icon(
              Icons.cloud_download,
              color: Colors.blue,
              size: 60,
            ),
            onTap: () {
          DatabaseService().addPost(wastePic, wasteNum, wasteLat, wasteLong);
          Navigator.pop(context);
        },
          )
        ],
      ),
    );
  }
}