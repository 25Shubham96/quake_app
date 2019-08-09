import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Map _myData;
List _features;

void main() async{

  _myData = await getJsonResponse();
  _features = _myData['features'];

  runApp(new MaterialApp(
    title: "MY Quake App",
    home: new Home(),
  ),
  );
}

class Home extends StatelessWidget {
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

        body: new Center(
          child: new ListView.builder(
            itemCount: _features.length,
            padding: new EdgeInsets.all(5),
            itemBuilder: (BuildContext context, int position) {
              if (position.isOdd) return new Divider();
              final index = position ~/2;

              var format = new DateFormat.yMMMMd("en_US").add_jm();
              var date = format.format(new DateTime.fromMicrosecondsSinceEpoch(_features[index]['properties']['time'] * 1000, isUtc: true));

              return new Column(
                children: <Widget>[
                  new ListTile(
                    title: new Text(
                      "$date",
                      style: new TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: new Text(
                      "${_features[index]['properties']['place']}",
                      style: new TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                      ),
                    ),

                    leading: new CircleAvatar(
                      backgroundColor: Colors.limeAccent,
                      child: new Text(
                        "${_features[index]['properties']['mag']}",
                        style: new TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    onTap: () {_showOnClick(context, "${_features[index]['properties']['title']}");}
                  ),

                ],
              );
            },

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

void _showOnClick(BuildContext context, String msg) {
  var alert = new AlertDialog(
    title: new Text("Quake"),
    content: new Text(msg),
    actions: <Widget>[
      new FlatButton(
          onPressed: () { Navigator.pop(context); }, 
          child: new Text("ok")),
    ],
  );
  showDialog(context: context, child: alert);
}