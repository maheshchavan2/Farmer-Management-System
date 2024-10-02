// ignore_for_file: camel_case_types, sized_box_for_whitespace, prefer_const_constructors, await_only_futures, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, avoid_print, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pie_chart/pie_chart.dart';

class crop_pattern_deatil_screen extends StatefulWidget {
  const crop_pattern_deatil_screen({super.key});

  @override
  State<crop_pattern_deatil_screen> createState() =>
      _crop_pattern_deatil_screenState();
}

class _crop_pattern_deatil_screenState
    extends State<crop_pattern_deatil_screen> {
  List<String> list = <String>['All Village', 'Two', 'Three', 'Four'];
  List<String> Chak_list = <String>['All Chak NO', 'Two', 'Three', 'Four'];
  List<String> Subchak_list = <String>[
    'All SubChak No',
    'Two',
    'Three',
    'Four'
  ];
  List<String> Year_list = <String>['Year', '2021', '2023', '2024'];
  List<String> Season_list = <String>['All Season', '2021', '2023', '2024'];
  List<String> All_Crop_list = <String>['All Crop', '2021', '2023', '2024'];
  String dropdownValue = "All Village";
  String dropdownValue2 = 'Select FRO';
  String dropdownValue3 = 'All Chak';

  final List<String> entries = <String>['A', 'B', 'C'];
  // final List<int> colorCodes = <int>[600, 500, 100];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: Text(
            'Crop Pattern Details',
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
                        child: DropdownMenu<String>(
                          initialSelection: list.first,
                          onSelected: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                          dropdownMenuEntries: list
                              .map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                                value: value, label: value);
                          }).toList(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownMenu<String>(
                          initialSelection: Chak_list.first,
                          onSelected: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue2 = value!;
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
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownMenu<String>(
                          initialSelection: Subchak_list.first,
                          onSelected: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                          dropdownMenuEntries:
                              Subchak_list.map<DropdownMenuEntry<String>>(
                                  (String value) {
                            return DropdownMenuEntry<String>(
                                value: value, label: value);
                          }).toList(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownMenu<String>(
                          initialSelection: Year_list.first,
                          onSelected: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue2 = value!;
                            });
                          },
                          dropdownMenuEntries:
                              Year_list.map<DropdownMenuEntry<String>>(
                                  (String value) {
                            return DropdownMenuEntry<String>(
                                value: value, label: value);
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownMenu<String>(
                          initialSelection: Season_list.first,
                          onSelected: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                          dropdownMenuEntries:
                              Season_list.map<DropdownMenuEntry<String>>(
                                  (String value) {
                            return DropdownMenuEntry<String>(
                                value: value, label: value);
                          }).toList(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownMenu<String>(
                          initialSelection: All_Crop_list.first,
                          onSelected: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue2 = value!;
                            });
                          },
                          dropdownMenuEntries:
                              All_Crop_list.map<DropdownMenuEntry<String>>(
                                  (String value) {
                            return DropdownMenuEntry<String>(
                                value: value, label: value);
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            onPressed: () {
                              print("DETAILS");
                            },
                            child: Text(
                              "DETAILS",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      Container(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            onPressed: () {
                              print("SUMMARY");
                            },
                            child: Text(
                              "SUMMARY",
                              style: TextStyle(color: Colors.white),
                            )),
                      )
                    ],
                  ),
                ),
                Divider(),
              ],
            ),
          ),
        ));
  }
}
