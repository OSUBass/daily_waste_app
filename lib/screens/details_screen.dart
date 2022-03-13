import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:wasteagram/models/post_model.dart';
import 'package:wasteagram/services/style.dart';

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
            Semantics(
              hint:'dispays date data was submitted',
              child: Text('${details.wasteDate}',
                style: WasteStyle.wasteDateDetails),
            ),
            const SizedBox(height:60),
             Expanded(
               child: Semantics(
                 image: true,
                 hint:'image of wasted items',
                 child: Image.network('${details.wastePic}',
                    height: 200,
                    ),
               ),
             ),
          
            const SizedBox(height:60),
            Semantics(
              hint:'text displaying items wasted',
              child: Text('${details.wasteNum} items leftover',
                style: WasteStyle.wasteNumDetails),
            ),
            const SizedBox(height:60),
            Semantics(
              hint:'text displays latitude and longitude at time of submission',
              child: Text('Location (${details.wasteLat} , ${details.wasteLong})',
              style: WasteStyle.wasteLocDetails),
            ),
            const SizedBox(height:40),
          ],
        ),
      ),
    );
  }
}