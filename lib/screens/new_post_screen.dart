//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wasteagram/services/db.dart';
import 'package:location/location.dart';

class NewPost extends StatefulWidget {
  const NewPost({ Key? key }) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final String wastePic = 'pic here'; 
  int wasteNum = 0; 
  String wasteLat = '0'; 
  String wasteLong= '0';

  LocationData? locationData;

  @override
  void initState(){
    super.initState();
    bool serviceEnabled = false;
    PermissionStatus permissionGranted= PermissionStatus.denied;
    retrieveLocation(serviceEnabled, permissionGranted);
  }

  void retrieveLocation(serviceEnabled, permissionGranted) async{
    Location location = Location();
    if (await checkServiceEnabled(location, serviceEnabled)){
      var permission = await checkPermissionGranted(location, permissionGranted);
      if(permission == PermissionStatus.granted){
        locationData = await location.getLocation();
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (locationData == null){
      return const Center(child: CircularProgressIndicator());
    }else{
      return Scaffold(
        appBar: AppBar(
          title: const Text('New Post')),
        body:Column(
          children: [
            const Text('upload pic here'),
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Enter the number of wasted items',
              ),
              onChanged: (value) => setState(() => wasteNum = int.parse(value)),
            ),
            GestureDetector(
              child: const Icon(
                Icons.cloud_download,
                color: Colors.blue,
                size: 60,
              ),
              onTap: () async  {
              wasteLong = locationData!.longitude.toString();
              wasteLat = locationData!.latitude.toString();
              await DatabaseService().addPost(wastePic, wasteNum, wasteLat, wasteLong);
              Navigator.pop(context);
              },
            )
          ]),
      );
    }
  }
}

Future<bool> checkServiceEnabled (location, _serviceEnabled) async {
   _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }
    return true;
}

Future<Enum> checkPermissionGranted(location, _permissionGranted)async {
   _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return PermissionStatus.denied;
        }
      }
      return PermissionStatus.granted;
}