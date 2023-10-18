import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ScrapedDataScreen extends StatefulWidget {
  @override
  _ScrapedDataScreenState createState() => _ScrapedDataScreenState();
}

class _ScrapedDataScreenState extends State<ScrapedDataScreen> {
  Map<String, dynamic> scrapedData = {}; // Use a Map to store the data

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://localhost/scraper'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        scrapedData = data;
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
            title: Text('Results: ${scrapedData['results']}',
                style: TextStyle(fontSize: 16.0)),
          ),
          ListTile(
            title: Text('Image Src: ${scrapedData['image_src']}',
                style: TextStyle(fontSize: 16.0)),
          ),
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
