import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ScrapedDataScreen extends StatefulWidget {
  @override
  _ScrapedDataScreenState createState() => _ScrapedDataScreenState();
}

class _ScrapedDataScreenState extends State<ScrapedDataScreen> {
  List<String> titles = [];
  List<String> categories = [];
  List<String> prices = [];
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
      setState(() {
        titles = List<String>.from(data['results']);
        categories = List<String>.from(data['categories']);
        prices = List<String>.from(data['price']);
        imageSrc = List<String>.from(data['image_src']);
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
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Display 2 items per row
        ),
        itemCount: 8, // Display the first 8 items
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: [
                Image.network(imageSrc[index], height: 100.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Title: ${titles[index]}',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Category: ${categories[index]}',
                        style: TextStyle(fontSize: 12.0),
                      ),
                      Text(
                        'Price: ${prices[index]}',
                        style: TextStyle(fontSize: 12.0),
                      ),
                    ],
                  ),
                ),
              ],
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
