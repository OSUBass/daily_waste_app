import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:wasteagram/models/post_model.dart';
import 'package:wasteagram/screens/details_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Stream<QuerySnapshot> _postStream = 
    FirebaseFirestore.instance.collection('posts').snapshots();

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
            return const CircularProgressIndicator();
          }else{
            List allPosts = snapshot.data!.docs;
            return ListView.separated(
              itemCount: allPosts.length,
              itemBuilder: (context, index) {
                Post currentPost = Post.fromFirestore(allPosts[index]);
                  return ListTile(
                    tileColor: Color.fromARGB(255, 243, 239, 202),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage('${currentPost.wastePic}'),
                    ),
                    title: Text('${currentPost.wasteDate}',
                      style: const TextStyle(
                        fontSize: 16,
                    ) ),
                    trailing: Text('${currentPost.wasteNum}',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                    ) ),
                    onTap: () => 
                      Navigator.push(context,MaterialPageRoute(
                        builder: (context) => Details(details: currentPost)),
                      ));
              },
              separatorBuilder: (context, index){
                return Divider(height: 3, color:Color.fromARGB(255, 165, 3, 57));
              }
            );
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>Navigator.pushNamed(context, '/post'),
        child: const Icon(Icons.add_task),
      ));
  }
}