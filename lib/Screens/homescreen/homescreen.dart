// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, avoid_unnecessary_containers, non_constant_identifier_names, camel_case_types

import 'dart:convert';

import 'package:farmer_management_system1/Models/login.dart';
import 'package:farmer_management_system1/Models/projectauthority.dart';
import 'package:farmer_management_system1/Screens/crop_advisory/crop-advisory.dart';
import 'package:farmer_management_system1/Screens/homescreen/Menu.dart';

import 'package:farmer_management_system1/Screens/homescreen/projectlist.dart';
import 'package:farmer_management_system1/Screens/login.dart';
import 'package:farmer_management_system1/Screens/user_attendance/user_attendance.dart';
import 'package:farmer_management_system1/operations/operations_api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homescreen extends StatefulWidget {
  homescreen({
    super.key,
  });

  // final List<String> states = <String>[
  //   'MADHYA PRADESH',
  //   'ODISHA',
  //   'MAHARASHTRA'
  // ];

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  int _selectedIndex = 0;
  User? userDetails;
  Set<String>? state = {};
  String? project_title = '';
  String? title = "STATE";
  // List<String> projectcount = [];
  // List<String> projectname = [];
  // List<String> statename = [];

  List<GetProjectAuthority?> projectList = [];
  List<String> Project_list = <String>[
    // 'All Porjects',
    // 'Kundalia LBC',
    // 'Kundalia RBC',
    // 'Pachore'
  ];
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
          if (userDetails!.roleName == "FRM") {
            title = "PROJECTS";
          }
        });
        projectList =
            await ApiService().getProjectAuthority(userDetails.userId ?? 0);
        Project_list.add(projectList[0]?.projectName ?? "");

        projectList.forEach(
          (element) {
            state?.add(element?.stateName ?? '');
          },
        );

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
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('${title}'),
        backgroundColor:
            Colors.blueAccent.shade200, // Replace with your desired title
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /* InkWell(
              child: Card(
                elevation: 10,
                // height: double.infinity,
                color: Colors.blueAccent.shade100,
                child: Center(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${projectList?.projectName ?? ''}',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                    ),
                    // Text('State Madhya Pradesh'),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "State :",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: "${projectList?.stateName ?? ''}",
                            style: TextStyle(color: Colors.black))
                      ])),
                    ),
                    // Text('Project group lspfg'),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "Project group :",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: "${projectList?.projectGroupName}",
                            style: TextStyle(color: Colors.black))
                      ])),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "Command area :",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: "${projectList?.cCA}",
                            style: TextStyle(color: Colors.black))
                      ])),
                    )
                  ],
                )),
              ),
              onTap: () {
                // Add your onTap logic here
        
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => projectlist()),
                  (Route<dynamic> route) => true,
                );
              },
            ),*/
            /*ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: getprojectlistcount(userDetails!.projects ?? ""),
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
                          child: Text(
                            '${projectList?.projectName ?? ''}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                        ),
                        // Text('State Madhya Pradesh'),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "State :",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: "${projectList?.stateName ?? ''}",
                                style: TextStyle(color: Colors.black))
                          ])),
                        ),
                        // Text('Project group lspfg'),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Project group :",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: "${projectList?.projectGroupName}",
                                style: TextStyle(color: Colors.black))
                          ])),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Command area :",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: "${projectList?.cCA}",
                                style: TextStyle(color: Colors.black))
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
                      MaterialPageRoute(builder: (context) => projectlist()),
                      (Route<dynamic> route) => true,
                    );
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),*/

            getWidget()
          ],
        ),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent.shade100,
              ),
              child: Column(
                children: [
                  Text(
                    'Saisanket Industries',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'FMS Mobile Application',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'App Version-V1.0',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Text(
                  //   "${userDetails?.username ?? 'Name'}",
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "${userDetails?.username ?? 'Name'}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 15)),
                      TextSpan(
                          text: " (${userDetails?.roleName ?? ''})",
                          style: TextStyle(color: Colors.black)),
                    ]),
                  )
                ],
              ),
            ),
            ListTile(
              title: const Text('Home'),
              // selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => homescreen()),
                  (Route<dynamic> route) => true,
                );
              },
            ),
            if (userDetails?.roleName?.toLowerCase() != "admin")
              ListTile(
                title: const Text('Attendence'),
                // selected: _selectedIndex == 1,
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(1);
                  // Then close the drawer
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => AttendanceScreen()),
                    (Route<dynamic> route) => true,
                  );
                },
              ),
            ListTile(
              title: const Text('Crop Advisory'),
              // selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => CropAdvisoryScreen()),
                  (Route<dynamic> route) => true,
                );
              },
            ),
            // ListTile(
            //   title: const Text('Chnage Language'),
            //   // selected: _selectedIndex == 2,
            //   onTap: () {
            //     // Update the state of the app
            //     _onItemTapped(2);
            //     // Then close the drawer
            //     Navigator.pop(context);
            //   },
            // ),
            ListTile(
              title: const Text('Log Out'),
              // selected: _selectedIndex == 2,
              onTap: () async {
                // Update the state of the app

                SharedPreferences pre = await SharedPreferences.getInstance();
                pre.clear();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // getprojectlistcount(projectlist_count) {
  //   // String projectIds = "2,3,4,5,6,7,8,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,66,67,68,69,70,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,133,135,136,137,138,139,140,141,142,143,144,145,146,147,161,162";

  //   List<String> projectIdsList = projectlist_count.split(',');

  //   int projectCount = projectIdsList.length;

  //   // print('Number of projects: $projectCount');
  //   return projectCount;
  // }

  Widget getWidget() {
    switch (userDetails?.roleName) {
      case "FRM":
        return Container(
          child: projectList.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: projectList.length,
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
                              child: Text(
                                '${projectList[index]?.projectName ?? ''}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                            ),
                            // Text('State Madhya Pradesh'),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "State :",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text:
                                        "${projectList[index]?.stateName ?? ''}",
                                    style: TextStyle(color: Colors.black))
                              ])),
                            ),
                            // Text('Project group lspfg'),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "Project group :",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text:
                                        "${projectList[index]?.projectGroupName}",
                                    style: TextStyle(color: Colors.black))
                              ])),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "Command area :",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: "${projectList[index]?.cCA}",
                                    style: TextStyle(color: Colors.black))
                              ])),
                            )
                          ],
                        )),
                      ),
                      onTap: () {
                        // Add your onTap logic here
                        // project_title = projectList[index]?.projectName ?? '';
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  menu_screen(projectList[index]!)),
                          (Route<dynamic> route) => true,
                        );
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ),
        );
      case "Admin":
        return Container(
          child: projectList.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  itemCount: state!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      child: Card(
                        elevation: 10,
                        // height: double.infinity,
                        color: Colors.blueAccent.shade100,
                        child: Center(
                            child: Column(
                          children: [
                            // Padding(
                            //   padding: EdgeInsets.all(8.0),
                            //   child: Text(
                            //     widget.states[index],
                            //     style: TextStyle(
                            //         fontWeight: FontWeight.bold, fontSize: 22),
                            //   ),
                            // ),
                            Padding(
                              padding: EdgeInsets.all(22.0),
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text:
                                        "${state?.elementAt(index).toUpperCase() ?? ''}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22))
                              ])),
                            ),
                            // Text('Project group lspfg'),
                          ],
                        )),
                      ),
                      onTap: () {
                        // Add your onTap logic here

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  projectlist(state!.elementAt(index))),
                          (Route<dynamic> route) => true,
                        );
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ),
        );
      /*return Container(
          child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: projectList.length ?? 0,
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
                        child: Text(
                          '${projectList[index]?.projectName ?? ''}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                      ),
                      // Text('State Madhya Pradesh'),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "State :",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: "${projectList[index]?.stateName ?? ''}",
                              style: TextStyle(color: Colors.black))
                        ])),
                      ),
                      // Text('Project group lspfg'),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Project group :",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: "${projectList[index]?.projectGroupName}",
                              style: TextStyle(color: Colors.black))
                        ])),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Command area :",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: "${projectList[index]?.cCA}",
                              style: TextStyle(color: Colors.black))
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
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        );
*/
      default:
        return Container(
          child: Text("error"),
        );
    }
  }
}
