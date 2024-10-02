// ignore_for_file: camel_case_types, sized_box_for_whitespace, prefer_const_constructors, await_only_futures, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, avoid_print, must_be_immutable, use_key_in_widget_constructors

import 'dart:convert';
import 'package:farmer_management_system1/Models/frolist.dart';
import 'package:farmer_management_system1/Models/login.dart';
import 'package:farmer_management_system1/Models/projectauthority.dart';
import 'package:farmer_management_system1/Models/village_nmaes.dart';
import 'package:farmer_management_system1/operations/operations_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class chak_assign_screen extends StatefulWidget {
  GetProjectAuthority? projectDetails;
  chak_assign_screen(GetProjectAuthority project) {
    projectDetails = project;
  }

  @override
  State<chak_assign_screen> createState() => _chak_assign_screenState();
}

class _chak_assign_screenState extends State<chak_assign_screen> {
  // List<String> FRO_list = <String>['Select FRO', 'Two', 'Three', 'Four'];
  List<String> Chak_list = <String>['All Chak', 'Assign Chak', 'Not Assign'];
  String dropdownValue = "All Village";
  String dropdownValue2 = 'Select FRO';
  String dropdownValue3 = 'All Chak';
  final colorList = <Color>[Colors.red, Colors.green];

  List<VillageList?> villageList = [];
  List<Frolist?> fro_list = [];
  final List<String> entries = <String>['A', 'B', 'C'];
  // final List<int> colorCodes = <int>[600, 500, 100];
  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user');
    final Map<String, dynamic> userMap = jsonDecode(user!);

    // Assuming you have a User class with a factory constructor `fromJson`
    final User userDetails = User.fromJson(userMap);
    villageList = await ApiService()
        .getVillageName(userDetails.userId!, widget.projectDetails!.projectId!);
    fro_list = await ApiService()
        .getFro_list(userDetails.userId!, widget.projectDetails!.projectId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: Text(
            'Chak Assignment',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor:
              Colors.blueAccent.shade200, // Replace with your desired title
        ),
        body: Container(
          child: Card(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownMenu<VillageList>(
                          initialSelection: villageList.first,
                          onSelected: (VillageList? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue = value!.villageId.toString();
                            });
                          },
                          dropdownMenuEntries: villageList
                              .map<DropdownMenuEntry<VillageList>>(
                                  (VillageList? value) {
                            return DropdownMenuEntry<VillageList>(
                                value: value!, label: value!.villageName ?? '');
                          }).toList(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DropdownMenu<Frolist>(
                          initialSelection: fro_list.first,
                          onSelected: (Frolist? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue2 = value!.froid!.toString();
                            });
                          },
                          dropdownMenuEntries: fro_list
                              .map<DropdownMenuEntry<Frolist>>(
                                  (Frolist? value) {
                            return DropdownMenuEntry<Frolist>(
                                value: value!, label: value.froname ?? "");
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownMenu<String>(
                    expandedInsets: EdgeInsets.zero,
                    initialSelection: Chak_list.first,
                    onSelected: (String? value) {
                      // ... your existing code for handling selection
                      setState(() {
                        dropdownValue3 = value!;
                      });
                    },
                    dropdownMenuEntries:
                        Chak_list.map<DropdownMenuEntry<String>>(
                            (String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: double.maxFinite,
                    width: double.infinity,
                    color: Colors.black12,
                    child: ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: entries.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          // height: ma,
                          color: Colors.white60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Village Name :',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          TextSpan(
                                              text: ' ${entries[index]}',
                                              style: TextStyle(
                                                  color: Colors.black)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: "Area :",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      TextSpan(
                                          text: ' ${entries[index]}',
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ])),
                                  ),
                                  // Text('Area : ${entries[index]}'),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: "No.of farmers",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      TextSpan(
                                          text: ' ${entries[index]}',
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ])),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       right: 25, top: 10),
                                  //   child: Container(
                                  //     // margin: EdgeInsets.,
                                  //     child: DropdownMenu<String>(
                                  //       initialSelection: FRO_list.first,
                                  //       onSelected: (String? value) {
                                  //         // This is called when the user selects an item.
                                  //         setState(() {
                                  //           dropdownValue2 = value!;
                                  //         });
                                  //       },
                                  //       dropdownMenuEntries: FRO_list.map<
                                  //               DropdownMenuEntry<String>>(
                                  //           (String value) {
                                  //         return DropdownMenuEntry<String>(
                                  //             value: value, label: value);
                                  //       }).toList(),
                                  //     ),
                                  //   ),
                                  // ),
                                  TextButton(
                                      onPressed: () {
                                        print("Assign FRO)");
                                      },
                                      child: Text(
                                        "ASSIGN FRO",
                                        style: TextStyle(color: Colors.green),
                                      ))
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
