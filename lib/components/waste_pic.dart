import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:wasteagram/screens/new_post_screen.dart';
import 'package:wasteagram/services/photo_services.dart';


class WastePic extends StatefulWidget {
  const WastePic({ Key? key }) : super(key: key);

  @override
  State<WastePic> createState() => _WastePicState();

}

class _WastePicState extends State<WastePic> {

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
          child: const Icon(Icons.add_a_photo),
          onPressed: () async {
            EasyLoading.dismiss();
            File image = await PicServices().getImage();
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return NewPost(image: image);}),
            );
          }
    );
  }
}