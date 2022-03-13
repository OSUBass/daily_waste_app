import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:wasteagram/components/waste_list_tile.dart';
import 'package:wasteagram/models/post_model.dart';
import 'package:wasteagram/screens/new_post_screen.dart';


class WasteList extends StatefulWidget {
  const WasteList({Key? key, required this.observer, required this.analytics}) : 
    super(key: key);
  
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  State<WasteList> createState() => _WasteList();
}

class _WasteList extends State<WasteList> {

  @override
  void initState() {
    super.initState();
     _logAppOpen();
  }

  //send analytics for log open appevent
  void _logAppOpen() async {
      await widget.analytics.logAppOpen();
    }
  //stream for wasteagram posts
  final Stream<QuerySnapshot> _postStream = 
    FirebaseFirestore.instance.collection('posts').orderBy('wasteDate', descending: true).snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
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

          //constructs appBar title
          int totalWaste = calcTotalWaste(allPosts);
          String appTitle = 'Wasteagram - $totalWaste';
    
          return Scaffold(
            appBar: AppBar(
              title: Text(appTitle),
              centerTitle: true,
            ),
          
          //Create Scrollable list tiles of all Waste posts from snapshot
          body: ListView.separated(
            itemCount: allPosts.length,
            itemBuilder: (context, index) {
              Map currentPostMapData = allPosts[index].data() as Map<String, dynamic>;
              Post currentPost = Post.fromMap(currentPostMapData);

              return Semantics(
                child: WasteListTile(currentPost: currentPost),
                button:true,
                onTapHint: 'Get details regarding selection'
                );
            },
            separatorBuilder: (context, index){return const Divider(height: 3,);}
          ),

          //Semantics code adapted from "Exploration: Accessibility and Internationalization"
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add_a_photo),
            onPressed: () async {
              EasyLoading.dismiss();
              Navigator.push(context,
                MaterialPageRoute(builder: (context) {
                  return const NewPost();}),
              );
            }
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, 
        );}
    );
  }
}

//calculates appBar title
int calcTotalWaste(posts){
  int waste = 0;
  for(int i =0; i<posts.length ;i++){
    Map thisPost = posts[i].data() as Map<String, dynamic>;
    Post thisData = Post.fromMap(thisPost);
    waste += thisData.wasteNum as int;
  }
  return waste;
}