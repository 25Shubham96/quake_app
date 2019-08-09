import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }

}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "My Quake App",
          style: new TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white
          ),
        ),

        backgroundColor: Colors.lightGreen,
      ),

      backgroundColor: Colors.limeAccent.shade100,

      body: new Center(
        child: new ListView.builder(
          itemBuilder: null,

        ),
      )
    );
  }
}

Future<Map> getJsonResponse() async{
  String apiURL = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson";

  http.Response response = await http.get(apiURL);

  return json.decode(response.body);
}