// ignore_for_file: prefer_const_constructors, camel_case_types, unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class irrigation_advice extends StatefulWidget {
  const irrigation_advice({super.key});

  @override
  State<irrigation_advice> createState() => _irrigation_adviceState();
}

class _irrigation_adviceState extends State<irrigation_advice> {
  List<String> list = <String>['Select Chak', 'Two', 'Three', 'Four'];
  String dropdownValue = 'All Chak';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        title: Text(
          "Irrigation Advise",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        // margin: const EdgeInsets.all(15.0),
        // padding: const EdgeInsets.all(3.0),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.2,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(border: Border.all()),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownMenu<String>(
                expandedInsets: EdgeInsets.zero,
                initialSelection: list.first,
                onSelected: (String? value) {
                  // ... your existing code for handling selection
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                dropdownMenuEntries:
                    list.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                // height: 10,
                thickness: 1,
                // indent: 2,
                // endIndent: 0,
                // color: Colors.black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {},
                      child: Text(
                        "Search",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
