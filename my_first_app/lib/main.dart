import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ScrapedDataScreen extends StatefulWidget {
  @override
  _ScrapedDataScreenState createState() => _ScrapedDataScreenState();
}

class _ScrapedDataScreenState extends State<ScrapedDataScreen> {
  List<String> results = [];
  List<String> imageSrc = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://localhost/scraper'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final resultsData = data['results'];
      final imageSrcData = data['image_src'];

      setState(() {
        results = List<String>.from(resultsData);
        imageSrc = List<String>.from(imageSrcData);
      });
    } else {
      print('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scraped Data'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Results:', style: TextStyle(fontSize: 16.0)),
          ),
          for (var result in results)
            ListTile(
              title: Text(result, style: TextStyle(fontSize: 16.0)),
            ),
          ListTile(
            title: Text('Image Src:', style: TextStyle(fontSize: 16.0)),
          ),
          for (var src in imageSrc)
            ListTile(
              title: Text(src, style: TextStyle(fontSize: 16.0)),
            ),
          ListTile(
            title: Text('Images:', style: TextStyle(fontSize: 16.0)),
          ),
          for (var src in imageSrc)
            Image.network(src), // Load and display images from URLs
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ScrapedDataScreen(),
  ));
}
