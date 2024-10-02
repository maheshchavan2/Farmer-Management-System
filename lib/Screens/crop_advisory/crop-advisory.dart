import 'package:farmer_management_system1/Models/CropAdvisory.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class CropAdvisoryScreen extends StatefulWidget {
  CropAdvisoryScreen({Key? key}) : super(key: key);

  @override
  State<CropAdvisoryScreen> createState() => _CropAdvisoryScreenState();
}

class _CropAdvisoryScreenState extends State<CropAdvisoryScreen> {
  late Future<List<CropAdvisoryModel>> _futureCropAdvisoryResponse;

  void initState() {
    super.initState();
    _futureCropAdvisoryResponse = fetchCropAdvisoryResponse();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Crop Advisory",
          style: TextStyle(),
        ),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: _futureCropAdvisoryResponse, // Reuse the future from initState
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text(
                'Awaiting result...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            var data = snapshot.data;
            return listViewBuilder(context, data);
          } else {
            return Center(child: Text('No data found.'));
          }
        },
      ),
    );
  }

  Widget listViewBuilder(BuildContext context, var values) {
    return ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: InkWell(
            onTap: launchMPKrishiURL,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    width: 18.0,
                    color: getColor(values[index].recommendation),
                  ),
                ),
              ),
              child: ListTile(
                leading: Material(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(150.0),
                  child: Container(
                    height: 60,
                    width: 60,
                    child: getImage(values[index].path),
                  ),
                ),
                title: Text(
                  'Crop: ${values[index].cropName}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 19.0,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  'Season: ${values[index].seasonName}',
                  style: TextStyle(
                    fontSize: 16,
                    color: getColor(values[index].recommendation),
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: getColor(values[index].recommendation),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getImage(String imagePath) {
    return FadeInImage.assetNetwork(
      placeholder: "assets/images/croperror.png", // Image shown while loading
      image: 'http://fms.seprojects.in$imagePath', // Network image URL
      imageErrorBuilder: (context, error, stackTrace) {
        // This is called when the image fails to load
        return Image.asset("assets/images/croperror.png");
      },
    );
  }

  Future<void> showColorsInformationDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                child: Text('ColorsRecommend'),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.close, color: Colors.red, size: 20),
              ),
            ],
          ),
          actions: [
            Divider(thickness: 3.0, color: Colors.grey),
            ListTile(
              leading: Icon(Icons.circle, color: Colors.green),
              title: Text('Recommended'),
            ),
            ListTile(
              leading: Icon(Icons.circle, color: Colors.orange),
              title: Text('Not Recommended'),
            ),
            ListTile(
              leading: Icon(Icons.circle, color: Colors.red),
              title: Text('Risky'),
            ),
          ],
        );
      },
    );
  }
}

class CropAdvisoryForm extends StatefulWidget {
  CropAdvisoryForm({Key? key}) : super(key: key);
  @override
  CropAdvisoryFormState createState() => CropAdvisoryFormState();
}

class CropAdvisoryFormState extends State<CropAdvisoryForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget listViewBuilder(BuildContext context, var values) {
    return ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: InkWell(
            onTap: launchMPKrishiURL,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    width: 18.0,
                    color: getColor(values[index].recommendation),
                  ),
                ),
              ),
              child: ListTile(
                leading: Material(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(150.0),
                  child: Container(
                    height: 60,
                    width: 60,
                    child: getImage(values[index].path),
                  ),
                ),
                title: Text(
                  'Crop: ${values[index].cropName}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 19.0,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  'Season: ${values[index].seasonName}',
                  style: TextStyle(
                    fontSize: 16,
                    color: getColor(values[index].recommendation),
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: getColor(values[index].recommendation),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: fetchCropAdvisoryResponse(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text(
              'Awaiting result...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return listViewBuilder(context, snapshot.data);
        } else {
          return Center(child: Text('No data found.'));
        }
      },
    );
  }

  Widget getImage(String imagePath) {
    return FadeInImage.assetNetwork(
      placeholder: "assets/images/croperror.png", // Image shown while loading
      image: 'http://fms.seprojects.in$imagePath', // Network image URL
      imageErrorBuilder: (context, error, stackTrace) {
        // This is called when the image fails to load
        return Image.asset("assets/images/croperror.png");
      },
    );
  }
}

Color getColor(String recommendation) {
  switch (recommendation) {
    case 'Recommended':
      return Colors.green;
    case 'Not Recommended':
      return Colors.orange;
    default:
      return Colors.red;
  }
}

Future<List<CropAdvisoryModel>> fetchCropAdvisoryResponse() async {
  try {
    final response = await http.get(Uri.parse(
        'http://fmsapi.seprojects.in/api/CropAdvisory/GetCropAdvisoryList?sid=1'));
    if (response.statusCode == 200) {
      List<dynamic> cropObject = jsonDecode(response.body);
      return cropObject
          .map<CropAdvisoryModel>((json) => CropAdvisoryModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load crop advisory data');
    }
  } catch (e) {
    print('Error fetching data: $e');
    return [];
  }
}

Future<void> launchMPKrishiURL() async {
  final Uri url = Uri.parse(
      'http://mpkrishi.mp.gov.in/Englishsite_New/krishi_capsules_Chana_New.aspx');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    print('Could not launch $url');
  }
}
