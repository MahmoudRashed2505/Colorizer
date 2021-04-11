import 'dart:convert';

import 'package:colorize/models/colorize.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    title: 'Colorize',
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const apiKey = '48c8563f-dcef-4b3b-94b0-d68bb1911a9a';
  static const api = 'https://api.deepai.org/api/colorizer';
  var output_image = '';

  Future<void> colorize(String imageUrl) {
    return http.post(Uri.parse(api), headers: {
      'api-key': apiKey
    }, body: {
      'image': imageUrl
    }).then((response) => {
          output_image = json.decode(response.body)["output_url"],
          print(output_image)
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Colorizer',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(labelText: 'Enter Image Url'),
              onSubmitted: (value) async {
                await colorize(value);
                setState(() {});
              },
            ),
          ),
          Container(
              height: 500,
              width: 500,
              child: output_image == ''
                  ? Center(child: Text('Enter a Url'))
                  : Image.network(output_image))
        ],
      )),
    );
  }
}
