// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:farmer_management_system1/Screens/homescreen/homescreen.dart';
import 'package:farmer_management_system1/Screens/login.dart';
import 'package:farmer_management_system1/Screens/loginscreens/spashscreen.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static String? mobile = '';
  @override
  void initState() {
    super.initState();
    requestLocationPermission();
  }

  bool isFirstLoad = true;
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      mobile = preferences.getString('user');
      setState(() {
        isFirstLoad = false;
      });
    });
    Widget getScreen() {
      try {
        if (mobile != null) {
          return homescreen();
        } else {
          return LoginPage();
        }
      } catch (ex) {
        return LoginPage();
      }
    }

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: isFirstLoad ? SplashScreen() : getScreen(),
    );
  }

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      // Permission granted, continue to access location.
    } else if (status.isDenied) {
      // Permission denied, handle accordingly.
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, open app settings.
      openAppSettings();
    }
  }
}
