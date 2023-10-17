import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ScrapedDataScreen extends StatefulWidget {
  @override
  _ScrapedDataScreenState createState() => _ScrapedDataScreenState();
}

class _ScrapedDataScreenState extends State<ScrapedDataScreen> {
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://localhost/scraper'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      setState(() {
        imageUrls = List<String>.from(data['image_src']);
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
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              imageUrls[index],
              width: 100,
              height: 100,
            ),
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
