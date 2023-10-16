import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch to full width
        children: <Widget>[
          Container(
            color: Colors.blue,
            height: 100, // Set the height as needed
            child: Center(
              child: Text(
                'Widget Block 1',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            color: Colors.green,
            height: 100, // Set the height as needed
            child: Center(
              child: Text(
                'Widget Block 2',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            color: Colors.orange,
            height: 100, // Set the height as needed
            child: Center(
              child: Text(
                'Widget Block 3',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
