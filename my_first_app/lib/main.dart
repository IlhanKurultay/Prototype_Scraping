import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ScrapedDataScreen extends StatefulWidget {
  @override
  _ScrapedDataScreenState createState() => _ScrapedDataScreenState();
}

class _ScrapedDataScreenState extends State<ScrapedDataScreen> {
  List<String> scrapedData = [];

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
        scrapedData = List<String>.from(data['image_src']);
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
      body: ListView.builder(
        itemCount: scrapedData.length,
        itemBuilder: (context, index) {
          return Image.network(
            scrapedData[index],
            width: 200, // Adjust the width as needed
            height: 200, // Adjust the height as needed
            fit: BoxFit.cover, // Choose the BoxFit based on your requirements
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ScrapedDataScreen(),
  ));
}
