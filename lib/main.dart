import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:wasteagram/screens/list_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //Firebase crashlytics line from https://stackoverflow.com/questions/64241615/how-to-initialize-firebase-crashlytics-in-flutter
  runZonedGuarded((){
    runApp(const MyApp());
  }, (error, stackTrace){
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  //Firebase analytics code from Exploration: Analytics and Crash Reporting
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = 
  FirebaseAnalyticsObserver(analytics: analytics);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wastagram',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        canvasColor: const Color.fromARGB(255, 5, 51, 8)
      ),
      builder: EasyLoading.init(),
      navigatorObservers: <NavigatorObserver>[observer],
      home: WasteList(
        analytics: analytics,
        observer: observer,
      ),
    );
  }
}
