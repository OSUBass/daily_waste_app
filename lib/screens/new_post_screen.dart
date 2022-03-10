//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/services/db.dart';
import 'package:location/location.dart';
import 'package:wasteagram/services/photo_storage.dart';
import 'dart:io';
import 'package:wasteagram/services/location.dart';

class NewPost extends StatefulWidget {
  const NewPost({ Key? key }) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  String wastePic = 'pic here'; 
  int wasteNum = 0; 
  String wasteLat = '0'; 
  String wasteLong= '0';
  File? image;
  final picker = ImagePicker();

  LocationData? locationData;

  //gets selected image and path using filepicker
  void getImage() async {
    final pickedFile = await picker.pickImage(source:ImageSource.gallery);
    image = File(pickedFile!.path);
    setState(() {});
  }

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

  @override
  Widget build(BuildContext context) {
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
                if (image == null)...[
                  const SizedBox(height: 25,),
                  const Text('Tap to upload pic',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),),
                  GestureDetector(
                    child: const Icon(
                      Icons.add_a_photo, 
                      size: 250,
                      color: Colors.white,
                    ),
                    onTap: () => getImage(),
                  ),
                ]else...[
                  Container(
                      padding: EdgeInsets.all(25),
                      height: 300,
                      width: 300,
                      child: Image.file(image!)
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    autofocus: true,
                    cursorColor: Colors.black,
                    textAlign: TextAlign.center,
                    maxLength: 4,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled:true,
                      fillColor: Colors.white,
                      hintText: 'Enter the number of wasted items',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold ),
                    ),
                    onChanged: (value) => setState(() => wasteNum = int.parse(value)),
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
                      wasteLong = locationData!.longitude.toString();
                      wasteLat = locationData!.latitude.toString();
                      wastePic = await Pic().addPic(image!);
                      await DatabaseService().addPost(wastePic, wasteNum, wasteLat, wasteLong);
                    
                      Navigator.pop(context);
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