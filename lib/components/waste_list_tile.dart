import 'package:flutter/material.dart';

import 'package:wasteagram/models/post_model.dart';
import 'package:wasteagram/screens/details_screen.dart';


class WasteListTile extends StatelessWidget {
  final Post currentPost;

  const WasteListTile({ Key? key, required this.currentPost }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: const Color.fromARGB(255, 243, 239, 202),
      leading: CircleAvatar(
        backgroundImage: NetworkImage('${currentPost.wastePic}'),
      ),
      title: Text('${currentPost.wasteDate}',
        style: const TextStyle(
          fontSize: 16,
      )),
      trailing: Text('${currentPost.wasteNum}',
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold
      )),
      onTap: () { 
        Navigator.push(context,MaterialPageRoute(
          builder: (context) => Details(details: currentPost)),
      );
    });
  }
}