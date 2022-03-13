import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:wasteagram/services/photo_services.dart';
import 'package:wasteagram/services/db.dart';


class Submit extends StatefulWidget {

  final Function() validateText;
  final File? image;
  final wasteNum;
  final locationData;

  const Submit({ Key? key, 
    required this.locationData, 
    required this.image,
    this.wasteNum,
    required this.validateText 
  }) : super(key: key);

  @override
  State<Submit> createState() => _SubmitState();
}

class _SubmitState extends State<Submit> {
  String wastePic = 
    'https://firebasestorage.googleapis.com/v0/b/wasteagram-15796.appspot.com/o/no%20photo.png?alt=media&token=1190ebf9-00ae-447f-a08c-4c3224a9a519';  
  String wasteLat = '0'; 
  String wasteLong= '0';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.bottomCenter,
        color: Colors.blue,
        child: Semantics(
          button: true,
          onTapHint:'upload data to database',
          child: const Icon(
            Icons.cloud_download,
            color: Colors.white,
            size: 120,
          ),
        ),
  ),
  onTap: () async  {
    if(widget.wasteNum!= null){
      EasyLoading.show(status: 'loading...');
      wasteLong = widget.locationData!.longitude.toString();
      wasteLat = widget.locationData!.latitude.toString();
      if (widget.image != null){wastePic = await PicServices().addPic(widget.image!);}
        await DatabaseService().addPost(wastePic, widget.wasteNum!, wasteLat, wasteLong);
        EasyLoading.dismiss();
        Navigator.pop(context);
      }else{widget.validateText(); }
  },  
    );
  }
}