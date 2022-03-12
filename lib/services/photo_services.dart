import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:image_picker/image_picker.dart';


class PicServices {

 //gets selected image and path using filepicker
  Future<File> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source:ImageSource.gallery);
    return File(pickedFile!.path);
  }

  //add pic to firebase storage and return URL
  Future<String> addPic(pic) async {
      var picRef = '${DateTime.now()}.jpg';
      await firebase_storage.FirebaseStorage.instance
        .ref(picRef)
        .putFile(pic);
      return await downloadURL(picRef);
    }

  //retrieve the picture URL from firebase stora
    Future downloadURL(petRef) async {
    return await firebase_storage.FirebaseStorage.instance
        .ref(petRef)
        .getDownloadURL();
    }
  }