
import 'package:intl/intl.dart';

class Post{
  String? wastePic;
  int? wasteNum;
  String? wasteDate;
  String? wasteLat;
  String? wasteLong;

  Post({this.wastePic,this.wasteNum, this.wasteDate, this.wasteLat, this.wasteLong});

  factory Post.fromMap(Map data){
    
    return Post(
      wastePic: data['wastePic'] ?? 'https://firebasestorage.googleapis.com/v0/b/wasteagram-15796.appspot.com/o/no%20photo.png?alt=media&token=1190ebf9-00ae-447f-a08c-4c3224a9a519',
      wasteNum: data['wasteNum'] ?? 0,
      wasteDate:convertDate(DateTime.fromMillisecondsSinceEpoch(data['wasteDate'])),
      wasteLat: data['wasteLat']?? '0',
      wasteLong: data['wasteLong']?? '0',
    );
  }
}

//Converts DateTime to string format ex: "Sunday, March 12, 2022"
String convertDate(time) {
  return DateFormat.yMMMMEEEEd().format(time);
}