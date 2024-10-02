// ignore_for_file: prefer_const_constructors, avoid_print, non_constant_identifier_names, camel_case_types, unused_import, unused_element, avoid_unnecessary_containers, unnecessary_string_interpolations

import 'package:farmer_management_system1/Models/projectauthority.dart';
import 'package:farmer_management_system1/Screens/Survey_detail_Screens/survey_Screen.dart';
import 'package:farmer_management_system1/Screens/chak_assign/chak_assign.dart';
import 'package:farmer_management_system1/Screens/crop_pattern_details/crop_pattern_details.dart';
import 'package:farmer_management_system1/Screens/homescreen/Menu.dart';
import 'package:farmer_management_system1/Screens/irrigation_advice/irrigation_advice.dart';
import 'package:farmer_management_system1/Screens/non_recommanded_crop_selection/non_recommanded_crop_sel.dart';

import 'package:flutter/material.dart';

class menu_screen extends StatefulWidget {
  GetProjectAuthority? projectDetails;
  menu_screen(GetProjectAuthority project) {
    projectDetails = project;
  }

  final List<String> menu_list = <String>[
    'Survey Page',
    'Chak Assign',
    'Cropping Pattern Details',
    'Non Recommanded Crop Selection',
    'Irrigation Advice'
  ];

  // final List<int> colorCodes = <int>[100, 100, 100];

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  State<menu_screen> createState() => _menu_screenState();
}

class _menu_screenState extends State<menu_screen> {
  String? title = "STATE";
  int _selectedIndex = 0;
  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text("${widget.projectDetails?.stateName!.toUpperCase()}"),
        backgroundColor:
            Colors.blueAccent.shade200, // Replace with your desired title
      ),
      body: Container(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: widget.menu_list.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              child: Card(
                elevation: 10,
                // height: double.infinity,
                color: Colors.blueAccent.shade100,
                child: Center(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${widget.menu_list[index]}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22)),
                    ),
                  ],
                )),
              ),
              onTap: () {
                // Add your onTap logic h
                print('Card tapped: ${widget.menu_list[index]}');
                getpageselection(index);
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
    );
  }

  getpageselection(int index) {
    switch (index) {
      case 0:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => survey_detail_screen()),
          (Route<dynamic> route) => true,
        );
        // Body of value1
        break;
      case 1:
        // Body of value2
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => chak_assign_screen(widget.projectDetails!)),
          (Route<dynamic> route) => true,
        );
        break;
      case 2:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => crop_pattern_deatil_screen()),
          (Route<dynamic> route) => true,
        );
        //
        break;
      case 3:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => non_recommanded_crop_sel()),
          (Route<dynamic> route) => true,
        );
        //
        break;
      case 4:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => irrigation_advice()),
          (Route<dynamic> route) => true,
        );
        //
        break;
      default:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => survey_detail_screen()),
          (Route<dynamic> route) => true,
        );
        // Body of default case
        break;
    }
  }
}
