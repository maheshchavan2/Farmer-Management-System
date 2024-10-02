// ignore_for_file: prefer_const_constructors, file_names, empty_catches, non_constant_identifier_names, unused_catch_stack, unused_local_variable, unrelated_type_equality_checks

import 'dart:convert';

import 'package:farmer_management_system1/Models/login.dart';
import 'package:farmer_management_system1/Models/projectauthority.dart';
import 'package:farmer_management_system1/Models/user_attendance.dart';
import 'package:farmer_management_system1/operations/operations_api.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String? username;
  bool isAttendanceAvai = false;
  late String now;
  bool? isLoader = true;
  User? userDetails;
  UserDetailsMasterModel? user_attendencemodel;

  List<GetProjectAuthority?> projectList = [];
  List<String> Project_list = <String>[
    // 'All Porjects',
    // 'Kundalia LBC',
    // 'Kundalia RBC',
    // 'Pachore'
  ];
  String dropdownValue = "All Porjects";
  @override
  void initState() {
    super.initState();
    now = DateFormat('yyyy-MMMM-dd').format(DateTime.now());
    getUserDetails();
    getData();
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
          isLoader = false;
        });

        projectList =
            await ApiService().getProjectAuthority(userDetails.userId ?? 0);
        Project_list.add(projectList[0]?.projectName ?? "");
        // project_name.add(projectList.)
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

  String? currentLocation;

  String? workingProject;

  String? StartLocationAddress, EndLocationAddress;
  String? startLocation = '';
  String? endLocation = '';
  String? btnName = 'Start Session';
  bool? bntpresent = true;

  getData() async {
    await fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      final int? userid = preferences.getInt('userid');
      final String attendanceEndpoint =
          'http://fmsapi.seprojects.in/api/login/GetTodaysAttendance?UserId=${userDetails?.userId}';

      final response = await http.get(Uri.parse(attendanceEndpoint));

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        if (json['Status'] == "Ok") {
          setState(() {
            isAttendanceAvai = true;
            btnName = 'End Session';
          });
          user_attendencemodel =
              UserDetailsMasterModel.fromJson(json['data']['Response']);

          if (user_attendencemodel!.attendanceEndLocation!.isNotEmpty)
          // if (user_attendencemodel != null &&
          //     user_attendencemodel!.endLocationCoordinate != null &&
          //     user_attendencemodel!.endLocationCoordinate!.isNotEmpty) {
          {
            bntpresent = false;
          } else {
            bntpresent = true;
          }

          fetchStartLocationAddress();
          fetchEndLocationAddress();
        } else {
          setState(() {
            isAttendanceAvai = false;
          });
          throw Exception("Login Failed");
        }
      } else {
        setState(() {
          isAttendanceAvai = false;
        });
        throw Exception("Login Failed");
      }
    } on Exception catch (_, ex) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade200,
        foregroundColor: Colors.white,
        title: Text("USER ATTENDANCE"),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey.shade200),
        child: isLoader!
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      elevation: 8,
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Text('Date : '),
                                    Text(
                                      now,
                                      style: TextStyle(color: Colors.cyan),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Text('User name : '),
                                    Text(
                                      userDetails?.username ?? "",
                                      style: TextStyle(color: Colors.cyan),
                                    )
                                  ],
                                ),
                              ),
                              if ((user_attendencemodel
                                          ?.attendanceStartLocation ??
                                      '')
                                  .isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Text('Start Time : '),
                                          Text(DateFormat('hh:mm:ss a').format(
                                              DateTime.parse(
                                                  user_attendencemodel!
                                                          .attendanceStartTime ??
                                                      ''))),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text('Start Location : '),
                                          Expanded(
                                              child: Text(
                                                  StartLocationAddress ?? '')),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              if ((user_attendencemodel
                                          ?.attendanceEndLocation ??
                                      '')
                                  .isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Text('End Time : '),
                                          Text(DateFormat('hh:mm:ss a').format(
                                              DateTime.parse(
                                                  user_attendencemodel!
                                                      .attendanceEndTime!))),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text('End Location : '),
                                          Expanded(
                                              child: Text(
                                                  EndLocationAddress ?? '')),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              if ((EndLocationAddress ?? '').isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Text('Total Working Hour : '),
                                      Text(user_attendencemodel!.workingHours ??
                                          ''),
                                    ],
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Working On Project : ',
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: DropdownMenu<String>(
                                          expandedInsets: EdgeInsets.zero,
                                          initialSelection: Project_list
                                                  .isNotEmpty
                                              ? Project_list[0]
                                              : null, // Ensure Project_list is not empty
                                          onSelected: (String? value) {
                                            if (value != null) {
                                              setState(() {
                                                dropdownValue = value;
                                              });
                                            }
                                          },
                                          dropdownMenuEntries: Project_list
                                                  .isNotEmpty
                                              ? Project_list.map<
                                                  DropdownMenuEntry<
                                                      String>>((String value) {
                                                  return DropdownMenuEntry<
                                                          String>(
                                                      value: value,
                                                      label: value);
                                                }).toList()
                                              : [], // If empty, return an empty list of entries
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (bntpresent!)
                                ElevatedButton(
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        btnName == 'Start Session'
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                      minimumSize: MaterialStateProperty.all(
                                        Size(
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                            40), // Change the width and height as needed
                                      ),
                                      shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),

                                          // Adjust the border radius as needed
                                          // Adjust the width and color
                                        ),
                                      )),
                                  /*style: ElevatedButton.styleFrom(
                                    backgroundColor: btnName == 'Start Session'
                                        ? Colors.green
                                        : Colors.red,
                                  ),*/
                                  onPressed: () async {
                                    bool serviceEnabled;
                                    LocationPermission permission;

                                    // Check if location services are enabled
                                    serviceEnabled = await Geolocator
                                        .isLocationServiceEnabled();
                                    if (!serviceEnabled) {
                                      return;
                                    }

                                    // Request location permission
                                    permission =
                                        await Geolocator.checkPermission();
                                    if (permission ==
                                        LocationPermission.deniedForever) {
                                      AlertDialog(
                                        title: Text('Enable Location'),
                                        content: Text(
                                            'Please enable location services to proceed.'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('CANCEL'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text('ENABLE'),
                                            onPressed: () {
                                              _enableLocationService();
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    }

                                    if (permission ==
                                        LocationPermission.denied) {
                                      // Location permissions are denied, request permission
                                      permission =
                                          await Geolocator.requestPermission();
                                      if (permission !=
                                              LocationPermission.whileInUse &&
                                          permission !=
                                              LocationPermission.always) {
                                        // Location permissions are denied (again), handle it accordingly
                                        return;
                                      }
                                    }

                                    // Get the current position
                                    Position position =
                                        await Geolocator.getCurrentPosition();

                                    // Retrieve the latitude and longitude
                                    double latitude = position.latitude;
                                    double longitude = position.longitude;
                                    if (btnName == 'Start Session') {
                                      startLocation =
                                          ('${latitude.toStringAsFixed(4)},${longitude.toStringAsFixed(4)}');
                                      await StartAttendance().then((value) {
                                        if (value) {
                                          fetchUserDetails();
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Error"),
                                                content: Text(
                                                    "Something went wrong."),
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                    child: Text("OK"),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      });
                                    } else {
                                      endLocation =
                                          ('${latitude.toStringAsFixed(4)},${longitude.toStringAsFixed(4)}');
                                      await EndAttendance().then((value) {
                                        if (value) {
                                          fetchUserDetails();
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Error"),
                                                content: Text(
                                                    "Something went wrong."),
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                    child: Text("OK"),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      });
                                    }

                                    setState(() {
                                      btnName = 'End Session';
                                    });
                                  },
                                  child: Text(btnName!.toString()),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void _enableLocationService() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {
      // Handle the scenario when the user has previously denied location permission permanently.
      // You may want to show a message or redirect them to settings.
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Handle the scenario when the user denies location permission.
        // You may want to show a message or perform some other action.
        return;
      }
    }

    // Location permission has been granted, and the user has enabled location services.
    // You can now proceed with the location-based functionality.
    // For example, you can start listening for location updates.
  }

  Future<void> fetchStartLocationAddress() async {
    double lat = double.parse(user_attendencemodel!.attendanceStartLocation!
        .substring(
            0, user_attendencemodel!.attendanceStartLocation!.indexOf(',')));
    double lon = double.parse(user_attendencemodel!.attendanceStartLocation!
        .substring(
            user_attendencemodel!.attendanceStartLocation!.indexOf(',') + 1));
    try {
      String address = await GetAddressFromLatLong(lat, lon);
      setState(() {
        StartLocationAddress = address;
      });
    } catch (ex) {
      // Handle the exception here, e.g., display an error message or fallback behavior
    }
  }

  Future<void> fetchEndLocationAddress() async {
    double lat = double.parse(user_attendencemodel!.attendanceEndLocation!
        .substring(
            0, user_attendencemodel!.attendanceEndLocation!.indexOf(',')));
    double lon = double.parse(user_attendencemodel!.attendanceEndLocation!
        .substring(
            user_attendencemodel!.attendanceEndLocation!.indexOf(',') + 1));
    try {
      String address = await GetAddressFromLatLong(lat, lon);
      setState(() {
        EndLocationAddress = address;
      });
    } catch (ex) {
      // Handle the exception here, e.g., display an error message or fallback behavior
    }
  }

  Future<String> GetAddressFromLatLong(double lat, double lon) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemarks[0];
    String? address =
        ' ${place.subLocality}, ${place.locality},${place.administrativeArea}, ${place.postalCode}';
    return address;
  }
// Future<String> getAddressFromLatLong(double lat, double lon) async {
//     List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);

//     if (placemarks.isNotEmpty) {
//       Placemark place = placemarks.first;
//       return '${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}';
//     }

//     return 'Address not found';
//   }

  Future<bool> StartAttendance() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      // int? userId = preferences.getInt('userid');

      // var projectId = selectProject!.id;

      var insertObj = <String, dynamic>{
        "AttendanceId": "",
        "AttendanceStartTime": "",
        "AttendanceEndTime": "",
        "AttendanceStartLocation": startLocation,
        "AttendanceEndLocation": "",
        "WorkingHours": "",
        "WorkingOnProject": int.tryParse(userDetails?.projects ?? ''),
        "UserId": userDetails?.userId,
        "TaskRemark": "start session",
        "AttendanceDate": (DateTime.now()).toString(),
      };

      var headers = {'Content-Type': 'application/json'};
      final request = http.Request(
        'POST',
        Uri.parse(
          'http://fmsapi.seprojects.in/api/login/InsertAttendanceDetails',
        ),
      );
      request.headers.addAll(headers);
      request.body = json.encode(insertObj);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        dynamic jsonResponse =
            jsonDecode(await response.stream.bytesToString());
        if (jsonResponse['Status'] == 'Ok') {
          return true;
        } else {
          throw Exception();
        }
      } else {
        throw Exception();
      }
    } catch (_, ex) {
      return false;
    }
  }

  Future<bool> EndAttendance() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      int? userId = preferences.getInt('userid');

      var projectId = userDetails!.projects;

      var insertObj = <String, dynamic>{
        // 'AttendanceId': user_attendencemodel!.attendanceId,
        // 'AttendanceStartTime': user_attendencemodel!.attendanceStartTime,
        // 'AttendanceEndTime': (DateTime.now()).toString(),
        // 'StartLocationCoordinate':
        //     user_attendencemodel!.startLocationCoordinate,
        // 'EndLocationCoordinate': endLocation,
        // "EndLocationPlacemark": "",
        // 'WorkingHours': '',
        // 'WorkingOnProjects': projectId,
        // 'UserId': userId,
        // 'AttendanceDate': (user_attendencemodel!.attendanceDate),
        "AttendanceId": user_attendencemodel!.attendanceId,
        "AttendanceStartTime": user_attendencemodel!.attendanceStartTime,
        "AttendanceEndTime": "",
        "AttendanceStartLocation":
            user_attendencemodel!.attendanceStartLocation,
        "AttendanceEndLocation": endLocation,
        "WorkingHours": "",
        "WorkingOnProject": user_attendencemodel?.workingOnProject,
        "UserId": userDetails?.userId,
        "TaskRemark": "End session",
        "AttendanceDate": (DateTime.now()).toString(),
      };

      var headers = {'Content-Type': 'application/json'};
      final request = http.Request(
        'POST',
        Uri.parse(
          'http://fmsapi.seprojects.in/api/login/InsertAttendanceDetails',
        ),
      );
      request.headers.addAll(headers);
      request.body = json.encode(insertObj);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        dynamic jsonResponse =
            jsonDecode(await response.stream.bytesToString());
        if (jsonResponse['Status'] == 'Ok') {
          return true;
        } else {
          throw Exception();
        }
      } else {
        throw Exception();
      }
    } catch (_, ex) {
      return false;
    }
  }
}
