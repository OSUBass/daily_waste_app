import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

import 'package:wasteagram/components/submit.dart';
import 'package:wasteagram/components/food_pic.dart';
import 'package:wasteagram/services/photo_services.dart';
import 'package:wasteagram/services/location.dart';
import 'package:wasteagram/services/style.dart';

class NewPost extends StatefulWidget {

  const NewPost({Key? key,}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  int? wasteNum; 
  bool _validate = false;
  final TextInputFormatter numOnly = FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));
  LocationData? locationData;
  File? image;

  @override
  void initState(){
    super.initState();
    loadImageTwo();
    bool serviceEnabled = false;
    PermissionStatus permissionGranted = PermissionStatus.denied;
    retrieveLocation(serviceEnabled, permissionGranted);
  }

  //load pic
  void loadImageTwo ()async {
    image = await PicServices().getImage();
    setState(() {});
  }

  //trigger error text if textbox is empty
  void validateText() =>setState((){_validate = true;});

  void retrieveLocation(serviceEnabled, permissionGranted) async{
    Location location = Location();
    LocationServices locService = LocationServices();
    if (await locService.checkServiceEnabled(location, serviceEnabled)){
      var permission = await locService.checkPermissionGranted(location, permissionGranted);
      if(permission == PermissionStatus.granted){
        locationData = await location.getLocation();
      }
    }setState(() {});}

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
                //displays foodwaste image
                FoodPic(image: image),
                
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Semantics(
                    textField: true,
                    hint:'entered value must be a number from 0-999',
                    child: TextField(
                      autofocus: true,
                      inputFormatters:[numOnly],
                      textAlign: TextAlign.center,
                      maxLength: 3,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        filled:true,
                        fillColor: Colors.white,
                        hintText: 'Enter the number of wasted items',
                        errorText: _validate ? 'Please enter a number from 0-999' : null,
                        hintStyle: WasteStyle.hintText),
                      onChanged: (value){
                          setState(() => wasteNum = int.parse(value));
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 160,),
                
                //submits data to firebase after validation
                Submit(locationData: locationData, 
                  image: image, 
                  wasteNum: wasteNum,
                  validateText: validateText
                )
              ],
            ),
          ),
        ),       
      );
    }
  }
}