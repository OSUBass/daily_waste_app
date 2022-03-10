import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Pic {
  //add pic to firebase storage and return URL
  Future<String> addPic(pic) async {
      var picRef = '${DateTime.now()}.jpg';

      await firebase_storage.FirebaseStorage.instance
        .ref(picRef)
        .putFile(pic);
      return await downloadURL(picRef);
    }
  }

  //retrieve the picture URL from firebase storage
  Future downloadURL(petRef) async {
    return await firebase_storage.FirebaseStorage.instance
        .ref(petRef)
        .getDownloadURL();
  }