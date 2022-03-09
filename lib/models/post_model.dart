
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Post{
  String? id;
  String? wastePic;
  int? wasteNum;
  String? wasteDate;
  String? wasteLat;
  String? wasteLong;

  Post({this.id, this.wastePic,this.wasteNum, this.wasteDate, this.wasteLat, this.wasteLong});

  factory Post.fromFirestore(DocumentSnapshot doc){
    Map data = doc.data() as Map<String, dynamic>;
    
    return Post(
      id: doc.id,
      wastePic: data['wastePic'],
      wasteNum: data['wasteNum'] ?? 0,
      wasteDate:convertDate(data['wasteDate']),
      wasteLat: data['wasteLat']?? 0,
      wasteLong: data['wasteLong']?? 0,
    );
  }
}

// Converts firebase timestamp to string format ex: "Sunday, March 12, 2022"
String convertDate(Timestamp? stamp) {
  DateTime stampDate = stamp!.toDate();
  String dateTime = DateFormat.yMMMMEEEEd().format(stampDate);
  return dateTime;
}