import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:wasteagram/models/post_model.dart';

class Details extends StatelessWidget {
  final Post details;
  
  const Details({ Key? key, required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wastegram'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Padding(
              padding: EdgeInsetsDirectional.all(15),
            ),
            const SizedBox(height:40),
            Text('${details.wasteDate}',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
            ) ),
            const SizedBox(height:60),
             Expanded(
               child: Image.network('${details.wastePic}',
                  height: 200,
                  ),
             ),
          
            const SizedBox(height:60),
            Text('${details.wasteNum} items leftover',
              style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
              ) ),
            const SizedBox(height:60),
            Text('Location (${details.wasteLat} , ${details.wasteLong})',
            style: const TextStyle(
                fontSize: 17,
                color: Colors.white,
            ) ),
            const SizedBox(height:40),
          ],
        ),
      ),
    );
  }
}