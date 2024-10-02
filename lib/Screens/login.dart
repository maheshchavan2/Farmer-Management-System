// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:farmer_management_system1/Models/login.dart';
import 'package:farmer_management_system1/Screens/homescreen/homescreen.dart';
import 'package:farmer_management_system1/Screens/homescreen/projectlist.dart';
import 'package:farmer_management_system1/operations/operations_api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false; // State variable for password visibility
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Stack(
        children: [
          // Background image container (optional)
          // ... (code from previous responses)

          // Centered content with padding
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Mobile number TextField with background color and numeric input
                TextField(
                  controller: _mobileNumberController,
                  decoration: InputDecoration(
                      labelText: 'Mobile number',
                      border: const OutlineInputBorder(),
                      fillColor: Colors.white, // Set background color
                      filled: true, // Enable background fill
                      suffixIcon: Icon(Icons.dialpad_sharp)),
                  keyboardType: TextInputType.number, // Only allow numbers
                ),
                const SizedBox(height: 16.0),

                // Password TextField with background color, show/hide icon
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    fillColor: Colors.white, // Set background color
                    filled: true, // Enable background fill
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText:
                      _passwordVisible, // Show/hide password based on state
                ),
                const SizedBox(height: 16.0),

                ElevatedButton(
                  onPressed: () async {
                    // Add your login logic here
                    String mobileNumber = _mobileNumberController.text;
                    String password = _passwordController.text;
                    User? userDetails =
                        await ApiService.loginUser(mobileNumber, password);


                    if (userDetails != null &&
                        userDetails.phoneNo == mobileNumber) {
                      final prefs = await SharedPreferences.getInstance();
                      String jsonString =
                          jsonEncode(userDetails); // Convert Map to JSON String
                      await prefs.setString('user',
                          jsonString); // Save JSON String in SharedPreferences

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Login Successful'),
                          content: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "Wlecome ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: "  ${(userDetails.username) ?? ""}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ])),
                          ),
                          actions: <Widget>[
                            TextButton(
                                child: Text('OK'),
                                onPressed: () async {
                                  ApiService.loginUser(mobileNumber, password);
                                  ApiService().getProjectAuthority(
                                      userDetails.userId ?? 0);
                                 
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => homescreen()),
                                    (Route<dynamic> route) => false,
                                  );
                                }),
                          ],
                        ),
                      );
                    } else {
                      // Login failed, show error pop-up
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Login Failed'),
                          content: Text('Invalid credentials'),
                          actions: <Widget>[
                            TextButton(
                                child: Text('OK'),
                                onPressed: () async {
                                  Navigator.pop(context);
                                }),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}
