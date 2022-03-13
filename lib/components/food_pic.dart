import 'dart:io';
import 'package:flutter/material.dart';

class FoodPic extends StatelessWidget {
  final File? image;
  
  const FoodPic({ Key? key, required this.image }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.all(25),
      height: 300,
      width: 300,
      child: Semantics(
        image:true,
        hint:'image of wasted food',
        child: Image.file(image!))
    );
  }
}