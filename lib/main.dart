import 'package:flutter_app1/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_core/firebase_core.dart';

Future<FirebaseApp> app = FirebaseApp.configure(

    options:FirebaseOptions(
      googleAppID: '1:212033502907:android:1625aa40a721be326ab39e',
      apiKey: 'AIzaSyBzTXae0UtiPcPCbPMJfr3IasOMG1Eg7Ec',
      databaseURL: 'https://random-e46d9.firebaseio.com',
    )
);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen()
    );
  }
}

