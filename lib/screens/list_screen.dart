import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:wasteagram/components/waste_list_tile.dart';
import 'package:wasteagram/components/waste_pic.dart';
import 'package:wasteagram/models/post_model.dart';

class WasteList extends StatefulWidget {
  const WasteList({Key? key}) : super(key: key);

  @override
  State<WasteList> createState() => _WasteList();
}

class _WasteList extends State<WasteList> {
  //stream for wasteagram posts
  final Stream<QuerySnapshot> _postStream = 
    FirebaseFirestore.instance.collection('posts').orderBy('wasteDate', descending: true).snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Wasteagram'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _postStream,
        builder: ( context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.hasError) {return const Text('Error');}
          
          if (snapshot.connectionState == ConnectionState.waiting) {
            EasyLoading.show(status: 'Loading....');
            return Container();}

          //Collect list of post docs
          List allPosts = snapshot.data!.docs;
          
          //Show Loading widget if post docs do not exist
          if(allPosts.isEmpty){EasyLoading.show(status: 'No Data Yet');}
          else{EasyLoading.dismiss();}
          
          //Create Scrollable list tiles of all Waste posts from snapshot
          return ListView.separated(
            itemCount: allPosts.length,
            itemBuilder: (context, index) {
              Post currentPost = Post.fromFirestore(allPosts[index]);
              return WasteListTile(currentPost: currentPost);
            },
            separatorBuilder: (context, index){return const Divider(height: 3,);}
          );
          }
      ),
      
      floatingActionButton: const WastePic(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, 
      );
  }
}