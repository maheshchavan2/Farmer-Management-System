// ignore_for_file: camel_case_types, unused_element, prefer_const_literals_to_create_immutables, avoid_print, non_constant_identifier_names

import 'dart:convert';

import 'package:farmer_management_system1/Models/login.dart';
import 'package:farmer_management_system1/Models/projectauthority.dart';
import 'package:farmer_management_system1/Screens/homescreen/Menu.dart';
import 'package:farmer_management_system1/operations/operations_api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class projectlist extends StatefulWidget {
  String? state;
  projectlist(String project) {
    state = project;
  }

  // final List<int> colorCodes = <int>[100, 100, 100];

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  State<projectlist> createState() => _projectlistState();
}

class _projectlistState extends State<projectlist> {
  int _selectedIndex = 0;

  List<GetProjectAuthority?> projectList = [];
  List<String> Project_list = <String>[
    // 'All Porjects',
    // 'Kundalia LBC',
    // 'Kundalia RBC',
    // 'Pachore'
  ];
  User? userDetails;
  Set<String>? state = {};
  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
    });
  }

  @override
  void initState() {
    getUserDetails();
    // getprojectlistcount(userDetails!.projects ?? "");
    // await getprojectlist(roleName!);
    super.initState();
  }

  Future<void> getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user');

    if (user != null) {
      try {
        final Map<String, dynamic> userMap = jsonDecode(user);

        // Assuming you have a User class with a factory constructor `fromJson`
        final User userDetails = User.fromJson(userMap);

        setState(() {
          this.userDetails = userDetails;
        });

        projectList =
            await ApiService().getProjectAuthority(userDetails.userId ?? 0);
        Project_list.add(projectList[0]?.projectName ?? "");

        // getprojectlistcount(
        //     userDetails.projects ?? 0); // Access properties safely
      } catch (e) {
        print('Error parsing JSON: $e');
        // Handle JSON parsing error
      }
    } else {
      setState(() {
        // Handle the null case appropriately
        this.userDetails = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<GetProjectAuthority?> projectDetailsList = projectList
        .where(
          (element) => element?.stateName == widget.state,
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          '${widget.state!.toUpperCase()}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor:
            Colors.blueAccent.shade200, // Replace with your desired title
      ),
      body: projectList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              itemCount: projectDetailsList.length,
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
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '${projectDetailsList[index]?.projectName ?? ''}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                        ),
                        // Text('State Madhya Pradesh'),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "State :",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    "${projectDetailsList[index]?.stateName ?? ''}",
                                style: TextStyle(color: Colors.black))
                          ])),
                        ),
                        // Text('Project group lspfg'),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Project group :",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    "${projectDetailsList[index]?.projectGroupName}",
                                style: TextStyle(color: Colors.black))
                          ])),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Command area :",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: "${projectDetailsList[index]?.cCA}",
                                style: TextStyle(color: Colors.black))
                          ])),
                        )
                      ],
                    )),
                  ),
                  onTap: () {
                    // Add your onTap logic here
                    // print('Card tapped: ${widget.states[index]}');
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              menu_screen(projectDetailsList[index]!)),
                      (Route<dynamic> route) => true,
                    );
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ), /*ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: widget.states.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Card(
              elevation: 10,
              // height: double.infinity,
              color: Colors.blueAccent[widget.colorCodes[index]],
              child: Center(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.states[index],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                          text: "State :",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: "Madhya Pradesh",
                          style: TextStyle(color: Colors.black))
                    ])),
                  ),
                  // Text('Project group lspfg'),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                          text: "Project group :",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: "lfdjk ", style: TextStyle(color: Colors.black))
                    ])),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                          text: "Command area :",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: "975 ha", style: TextStyle(color: Colors.black))
                    ])),
                  )
                ],
              )),
            ),
            onTap: () {
              // Add your onTap logic here
              print('Card tapped: ${widget.states[index]}');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => menu_screen()),
                (Route<dynamic> route) => true,
              );
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),*/
    );
  }
}
