// ignore_for_file: camel_case_types, sized_box_for_whitespace, prefer_const_constructors, await_only_futures

import 'dart:convert';

import 'package:farmer_management_system1/Models/login.dart';
import 'package:farmer_management_system1/Models/survey.dart';
import 'package:farmer_management_system1/operations/operations_api.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class survey_detail_screen extends StatefulWidget {
  const survey_detail_screen({super.key});

  @override
  State<survey_detail_screen> createState() => _survey_detail_screenState();
}

class _survey_detail_screenState extends State<survey_detail_screen> {
  var dataMap = <String, double>{"Not Survey": 19, "Survey": 15};
  int notSurvey = 0;
  int Survey_data = 0;
  User? userDetails;
  List<Survey_page?> frmdata = [];
  final colorList = <Color>[Colors.red, Colors.green];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
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

        frmdata = await ApiService().getSurveyAnalysis(userDetails.userId ?? 0);
        notSurvey = frmdata[0]?.notSurvey ?? 0;
        Survey_data = frmdata[0]?.surveyed ?? 0;
        dataMap = {
          "Not Survey": notSurvey.toDouble(),
          "Survey": Survey_data.toDouble()
        };

        print(frmdata[0]);
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
        title: Text(
          'Servey Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor:
            Colors.blueAccent.shade200, // Replace with your desired title
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: Colors.white,
        backgroundColor: Colors.blue,
        strokeWidth: 3.5,
        onRefresh: () async {
          // Replace this delay with the code to be executed during refresh
          // and return a Future when code finishes execution.
          return Future<void>.delayed(const Duration(seconds: 3));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 15,
            color: Colors.grey.shade200,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width,
                      child: PieChart(
                        dataMap: dataMap,
                        chartType: ChartType.disc,
                        baseChartColor: Colors.grey[300]!,
                        colorList: colorList,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Project Name  :",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 18)),
                      TextSpan(
                        text: frmdata.isNotEmpty
                            ? ' ${frmdata[0]?.projectName ?? ''}'
                            : 'No Data Available',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      )
                    ])),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Area Allocated  :",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 18)),
                      TextSpan(
                          text: frmdata.isNotEmpty
                              ? ' ${frmdata[0]?.areaAllocated ?? ''}'
                              : 'No Data Available',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16))
                    ])),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "No.Of FROs  :",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 18)),
                      TextSpan(
                          text: frmdata.isNotEmpty
                              ? ' ${frmdata[0]?.noOfFROs ?? ''}'
                              : 'No Data Available',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16))
                    ])),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "No.Of Farmers  :",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 18)),
                      TextSpan(
                          text: frmdata.isNotEmpty
                              ? ' ${frmdata[0]?.noOfFarmer ?? ''}'
                              : 'No Data Available',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16))
                    ])),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        onPressed: () {
          // Show refresh indicator programmatically on button tap.
          getUserDetails();
          _refreshIndicatorKey.currentState?.show();
        },
        label: const Text('Reload'),
        icon: const Icon(Icons.refresh),
      ),
    );
  }
}
