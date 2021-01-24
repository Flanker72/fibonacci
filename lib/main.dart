import 'package:fiboeda/app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error.toString());
        }
        if (snapshot.hasData) {
          return App();
        }
        return Container(color: Colors.black);
      },
    ),
  );
}
