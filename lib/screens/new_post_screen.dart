import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:location/location.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:wasteagram/services/photo_services.dart';
import 'package:wasteagram/services/location.dart';
import 'package:wasteagram/services/db.dart';

class NewPost extends StatefulWidget {

  final File? image;
  const NewPost({ Key? key, required this.image }) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  String wastePic = 
    'https://firebasestorage.googleapis.com/v0/b/wasteagram-15796.appspot.com/o/no%20photo.png?alt=media&token=1190ebf9-00ae-447f-a08c-4c3224a9a519'; 
  int? wasteNum; 
  String wasteLat = '0'; 
  String wasteLong= '0';
  bool _validate = false;
  final TextInputFormatter numOnly = FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));

  LocationData? locationData;

  @override
  void initState(){
    super.initState();
    bool serviceEnabled = false;
    PermissionStatus permissionGranted = PermissionStatus.denied;
    retrieveLocation(serviceEnabled, permissionGranted);
  }

  void retrieveLocation(serviceEnabled, permissionGranted) async{
    Location location = Location();
    LocationServices locService = LocationServices();
    if (await locService.checkServiceEnabled(location, serviceEnabled)){
      var permission = await locService.checkPermissionGranted(location, permissionGranted);
      if(permission == PermissionStatus.granted){
        locationData = await location.getLocation();
      }
    }
    setState(() {});
  }

  bool validateInput(String value){
        RegExp regExp = RegExp(r'^[0-9999]+');
        return regExp.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    //image = ModalRoute.of(context)!.settings.arguments as File;
    
    if (locationData == null){
      return const Center(child: CircularProgressIndicator());
    }else{
      return Scaffold(
        appBar: AppBar(
          title: const Text('Wasteagram'),
          centerTitle: true,),
        body:SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(25),
                    height: 300,
                    width: 300,
                    child: Image.file(widget.image!)
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    autofocus: true,
                    inputFormatters:[numOnly],
                    cursorColor: Colors.black,
                    textAlign: TextAlign.center,
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      filled:true,
                      fillColor: Colors.white,
                      hintText: 'Enter the number of wasted items',
                      errorText: _validate ? 'Please enter a number from 0-999' : null,
                      hintStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold ),
                    ),
                    onChanged: (value){
                      if(validateInput(value)){
                        setState(() => wasteNum = int.parse(value));
                      }
                    },
                  ),
                ),
                const SizedBox(height: 160,),
                GestureDetector(
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          color: Colors.blue,
                          child: const Icon(
                            Icons.cloud_download,
                            color: Colors.white,
                            size: 120,
                          ),
                    ),
                    onTap: () async  {
                      if(wasteNum != null){
                        EasyLoading.show(status: 'loading...');
                        wasteLong = locationData!.longitude.toString();
                        wasteLat = locationData!.latitude.toString();
                        if (widget.image != null){wastePic = await PicServices().addPic(widget.image!);}
                        await DatabaseService().addPost(wastePic, wasteNum!, wasteLat, wasteLong);
                        EasyLoading.dismiss();
                        Navigator.pop(context);
                      }else{
                       setState((){_validate = true;});
                      }
                    },
                  ),
              ],
            ),
          ),
        ),       
      );
    }
  }
}