import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import 'package:wasteagram/models/post_model.dart';

void main() {
  
  test('Test1: Post created from Map has correct property values', () {
    const url = 'Fake';
    const quantity = 1;
    final date = DateTime.now().millisecondsSinceEpoch;
    const latitude = '1.0';
    const longitude = '2.0';

    final wasteagramPost = Post.fromMap({
      'wastePic' : url,
      'wasteNum' :quantity,
      'wasteDate' : date,
      'wasteLat' : latitude,
      'wasteLong' : longitude,
    });

    expect(wasteagramPost.wastePic, url);
    expect(wasteagramPost.wasteNum, quantity);
    expect(wasteagramPost.wasteDate, DateFormat.yMMMMEEEEd().format(DateTime.fromMillisecondsSinceEpoch(date)));
    expect(wasteagramPost.wasteLat, latitude);
    expect(wasteagramPost.wasteLong, longitude);

  });

  test('Test2: Post created from Map has correct property values', () {
    const url = 'Fake';
    const quantity = 1000;
    final date = DateTime.now().millisecondsSinceEpoch;
    const latitude = '1.756745';
    const longitude = '-232.0234323';

    final wasteagramPost = Post.fromMap({
      'wastePic' : url,
      'wasteNum' :quantity,
      'wasteDate' : date,
      'wasteLat' : latitude,
      'wasteLong' : longitude,
    });

    expect(wasteagramPost.wastePic, url);
    expect(wasteagramPost.wasteNum, quantity);
    expect(wasteagramPost.wasteDate, DateFormat.yMMMMEEEEd().format(DateTime.fromMillisecondsSinceEpoch(date)));
    expect(wasteagramPost.wasteLat, latitude);
    expect(wasteagramPost.wasteLong, longitude);

  });

  test('Test3: Post created from Map with null values has correct property values', () {
    const url = null;
    const quantity = null;
    final date = DateTime.now().millisecondsSinceEpoch;
    const latitude = null;
    const longitude = null;

    final wasteagramPost = Post.fromMap({
      'wastePic' : url,
      'wasteNum' :quantity,
      'wasteDate' : date,
      'wasteLat' : latitude,
      'wasteLong' : longitude,
    });

    expect(wasteagramPost.wastePic,'https://firebasestorage.googleapis.com/v0/b/wasteagram-15796.appspot.com/o/no%20photo.png?alt=media&token=1190ebf9-00ae-447f-a08c-4c3224a9a519');
    expect(wasteagramPost.wasteNum, 0);
    expect(wasteagramPost.wasteDate, DateFormat.yMMMMEEEEd().format(DateTime.fromMillisecondsSinceEpoch(date)));
    expect(wasteagramPost.wasteLat, '0');
    expect(wasteagramPost.wasteLong, '0');

  });
}
