import 'package:flutter/material.dart';

class CropAdvisoryWebView extends StatefulWidget {
  const CropAdvisoryWebView({super.key});

  @override
  State<CropAdvisoryWebView> createState() => _CropAdvisoryWebViewState();
}

class _CropAdvisoryWebViewState extends State<CropAdvisoryWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebView Example'),
      ),
      // body: WebView(
      //   initialUrl: url,
      //   javascriptMode: JavascriptMode.unrestricted,
      // ),
    );
  }
}
