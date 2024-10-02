// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:farmer_management_system1/Models/frolist.dart';
import 'package:farmer_management_system1/Models/login.dart';
import 'package:farmer_management_system1/Models/projectauthority.dart';
import 'package:farmer_management_system1/Models/survey.dart';
import 'package:farmer_management_system1/Models/village_nmaes.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<User?> loginUser(String mobileNumber, String password) async {
    // Replace with your actual API endpoint
    final url = Uri.parse(
        'http://fmsapi.seprojects.in/api/login/Login?LoginId=$mobileNumber&Password=$password');
    print(
        'http://fmsapi.seprojects.in/api/login/Login?LoginId=$mobileNumber&Password=$password');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final Map<String, dynamic> responseData = data['data']['Response'];

        // Extract user details and create a User object
        final user = User.fromJson(responseData);
        print(user);
        return user;
      } else {
        print('Failed to login: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error logging in: $error');
      return null;
    }
  }

  // Future<List<GetProjectAuthority?>> getProjectAuthority(int userId) async {
  //   try {
  //     // SharedPreferences preferences = await SharedPreferences.getInstance();
  //     // int? userid = preferences.getInt('userid');
  //     final response = await http.get(Uri.parse(
  //         'http://fmsapi.seprojects.in/api/project/GetProjectAuthority?UserId=$userId'));

  //     print('State List Api');
  //     print(
  //         'http://fmsapi.seprojects.in/api/project/GetProjectAuthority?UserId=$userId');
  //     if (response.statusCode == 200) {
  //       var json = jsonDecode(response.body);
  //       List<GetProjectAuthority> fetchedData = <GetProjectAuthority>[];
  //       json['data']['Response']
  //           .forEach((e) => fetchedData.add(GetProjectAuthority.fromJson(e)));

  //       return fetchedData;
  //     } else {
  //       throw Exception('Failed to load API');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to load API');
  //   }
  // }

  Future<List<GetProjectAuthority?>> getProjectAuthority(int userId) async {
    try {
      final url = Uri.parse(
          'http://fmsapi.seprojects.in/api/project/GetProjectAuthority?UserId=$userId');

      // Implement retry logic with exponential backoff
      int retryCount = 0;
      int maxRetries = 3; // Adjust based on your requirements
      int backoffDuration = 2; // Adjust retry delay in seconds

      Future<List<GetProjectAuthority?>> fetchData() async {
        final response = await http.get(url);
        if (response.statusCode == 200) {
          var json = jsonDecode(response.body);
          List<GetProjectAuthority> fetchedData = <GetProjectAuthority>[];
          json['data']['Response']
              .forEach((e) => fetchedData.add(GetProjectAuthority.fromJson(e)));
          return fetchedData;
        } else {
          throw Exception(
              'Failed to load API (Status: ${response.statusCode})');
        }
      }

      return await fetchData().catchError((error) async {
        if (error is SocketException && error.osError?.errorCode == OSError) {
          // Check for "Connection reset by peer"
          retryCount++;
          if (retryCount <= maxRetries) {
            print(
                'Connection reset by peer. Retrying $retryCount/$maxRetries...');
            await Future.delayed(Duration(seconds: backoffDuration));
            return fetchData(); // Retry the request
          } else {
            throw Exception(
                'Failed to load API after retries'); // Exhausted retries
          }
        } else {
          print("error"); // Rethrow other errors
        }
      });
    } catch (e) {
      throw Exception('Unexpected error: $e'); // Handle other exceptions
    }
  }

  Future<List<Survey_page?>> getSurveyAnalysis(int frmId) async {
    final url =
        'http://fmsapi.seprojects.in/api/SurveyAnalysis/GetFRMSurveyAnalysisDetail?FrmId=$frmId';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        List<Survey_page> fetchedData = <Survey_page>[];

        if (json['data']['Response'] is Map<String, dynamic>) {
          fetchedData.add(Survey_page.fromJson(json['data']['Response']));
        }

        return fetchedData;
      } else {
        throw Exception('Failed to load API');
      }
    } catch (e) {
      print('Error occurred: $e');
      return [];
    }
  }

  Future<List<VillageList?>> getVillageName(int userId, int projectId) async {
    final url =
        'http://fmsapi.seprojects.in/api/SurveyAnalysis/GetVillageListByRoleId?UserId=$userId&ProjectId=$projectId';
    print(url);

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        List<VillageList> fetchedData = [];

        // Check if the response is a list
        if (json['data']['Response'] is List) {
          // Iterate over the list and add each village to fetchedData
          for (var item in json['data']['Response']) {
            fetchedData.add(VillageList.fromJson(item));
          }
        } else if (json['data']['Response'] is Map<String, dynamic>) {
          // If it's a single object (not a list), add it directly
          fetchedData.add(VillageList.fromJson(json['data']['Response']));
        }

        return fetchedData;
      } else {
        throw Exception('Failed to load API');
      }
    } catch (e) {
      print('Error occurred: $e');
      return [];
    }
  }

  Future<List<Frolist?>> getFro_list(int userId, int projectId) async {
    final url =
        'http://fmsapi.seprojects.in/api/SurveyAnalysis/GetFROSurveyAnalysisDetailList_New?FrmId=$userId&ProjectId=$projectId';
    print(url);

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        List<Frolist> fetchedData = [];

        // Check if the response is a list
        if (json['data']['Response'] is List) {
          // Iterate over the list and add each village to fetchedData
          for (var item in json['data']['Response']) {
            fetchedData.add(Frolist.fromJson(item));
          }
        } else if (json['data']['Response'] is Map<String, dynamic>) {
          // If it's a single object (not a list), add it directly
          fetchedData.add(Frolist.fromJson(json['data']['Response']));
        }

        return fetchedData;
      } else {
        throw Exception('Failed to load API');
      }
    } catch (e) {
      print('Error occurred: $e');
      return [];
    }
  }
}
