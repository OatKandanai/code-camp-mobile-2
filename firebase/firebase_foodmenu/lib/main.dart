import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase/app/home.dart';

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // uploadJson();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

// Future<void> uploadJson() async {
//   final String jsonString = await rootBundle.loadString('assets/food.json');
//   final List<dynamic> data = jsonDecode(jsonString);
//   final List<Map<String, dynamic>> menuList = data.cast<Map<String, dynamic>>();
//   final collection = FirebaseFirestore.instance.collection('menu');
//   for (var item in menuList) {
//     await collection.add(item);
//   }
// }
