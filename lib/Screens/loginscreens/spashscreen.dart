// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void initState() {
    //super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: const Alignment(
                0.5,
                -3.0616171314629196e-17,
              ),
              end: const Alignment(
                0.5,
                0.9999999999999999,
              ),
              colors: [
                Colors.blue.shade100,
                Colors.lightBlue.shade700,
              ],
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: const Alignment(
                  0.5,
                  -3.0616171314629196e-17,
                ),
                end: const Alignment(
                  0.5,
                  0.9999999999999999,
                ),
                colors: [
                  Colors.blue.shade100,
                  Colors.lightBlue.shade700,
                ],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 99.00,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  /// Company Logo
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 18.00,
                                      right: 18.00,
                                    ),
                                    child: Image.network(
                                      'https://imgs.search.brave.com/uc2Ejnr7NncZDqP0m07UXDL5VL_ERX8j5o--zWjwkh4/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9jZG4u/cGl4YWJheS5jb20v/cGhvdG8vMjAxNy8x/MC8yOS8xNS81OC90/cmVlcy0yOTAwMDY0/XzY0MC5qcGc',
                                      height: 126.00,
                                      width: 186.00,
                                      fit: BoxFit.fill,
                                    ),
                                  ),

                                  ///Image set
                                  Container(
                                    height: 270,
                                    // width: 326.00,
                                    margin: EdgeInsets.only(
                                      left: 18.00,
                                      top: 60.00,
                                      right: 18.00,
                                    ),

                                    ///Polygon Image
                                    child: Stack(
                                      alignment: Alignment.bottomLeft,
                                      children: [
                                        ///Right
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Image.network(
                                            'https://imgs.search.brave.com/uc2Ejnr7NncZDqP0m07UXDL5VL_ERX8j5o--zWjwkh4/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9jZG4u/cGl4YWJheS5jb20v/cGhvdG8vMjAxNy8x/MC8yOS8xNS81OC90/cmVlcy0yOTAwMDY0/XzY0MC5qcGc',
                                            height: 138.00,
                                            width: 138.00,
                                            // fit: BoxFit.fill,
                                          ),
                                        ),

                                        ///Left
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Image.network(
                                            'https://imgs.search.brave.com/uc2Ejnr7NncZDqP0m07UXDL5VL_ERX8j5o--zWjwkh4/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9jZG4u/cGl4YWJheS5jb20v/cGhvdG8vMjAxNy8x/MC8yOS8xNS81OC90/cmVlcy0yOTAwMDY0/XzY0MC5qcGc',
                                            height: 138.00,
                                            width: 138.00,
                                            // fit: BoxFit.fill,
                                          ),
                                        ),

                                        ///top
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Image.network(
                                            'https://imgs.search.brave.com/uc2Ejnr7NncZDqP0m07UXDL5VL_ERX8j5o--zWjwkh4/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9jZG4u/cGl4YWJheS5jb20v/cGhvdG8vMjAxNy8x/MC8yOS8xNS81OC90/cmVlcy0yOTAwMDY0/XzY0MC5qcGc',
                                            height: 138.00,
                                            width: 138.00,
                                            // fit: BoxFit.fill,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  ///App Details
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 18.00,
                                      top: 34.04,
                                      right: 18.00,
                                    ),
                                    child: Text(
                                      "Farmer Management System",
                                      textScaleFactor: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 22,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 18.00,
                                      top: 5.00,
                                      right: 18.00,
                                    ),
                                    child: Text(
                                      "FMS",
                                      textScaleFactor: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 22,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 18.00,
                                      top: 4.00,
                                      right: 18.00,
                                    ),
                                    child: Text(
                                      "Version 2.0.0",
                                      textScaleFactor: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Container(
                          //   width: (
                          //     201.00,
                          //   ),
                          //   margin: EdgeInsets.only(
                          //     left: (
                          //       80.00,
                          //     ),
                          //     top: (
                          //       11.00,
                          //     ),
                          //     right: (
                          //       79.00,
                          //     ),
                          //     bottom: (
                          //       20.00,
                          //     ),
                          //   ),
                          //   child: Text(
                          //     "Water \nManagement \nSystem",
                          //     maxLines: null,
                          //     textAlign: TextAlign.center,
                          //     style: TextStyle(
                          //       color: ColorConstant.whiteA700,
                          //       fontMediaQuery.of(context).size: getFontMediaQuery.of(context).size(
                          //         30,
                          //       ),
                          //       fontFamily: 'Inter',
                          //       fontWeight: FontWeight.w700,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
