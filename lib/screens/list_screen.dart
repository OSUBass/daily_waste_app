import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('List View'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('List View')
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>Navigator.pushNamed(context, '/post'),
        child: const Icon(Icons.add),
      ),
    );// This trailing comma makes auto-formatting nicer for build methods.
  }
}