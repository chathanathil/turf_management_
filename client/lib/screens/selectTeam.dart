import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turf/screens/teamDetails.dart';

class SelectTeam extends StatelessWidget {
  static const routeName = "/select-team";
  final String date;
  final String time;
  SelectTeam({this.date, this.time});

  SharedPreferences sp;

  Future<Map<dynamic, dynamic>> _slots() async {
    final url =
        "http://sleepy-falls-05306.herokuapp.com/api/matchs/$date/$time";

    try {
      sp = await SharedPreferences.getInstance();

      final response = await http.get(url,
          headers: {HttpHeaders.authorizationHeader: sp.getString("jwt")});
      final extractData = json.decode(response.body);

      return extractData;
    } catch (error) {
      throw error;
    }
  }

  void _next(BuildContext context, String team) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) =>
                new TeamDetails(date: date, time: time, team: team)));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                "Select",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder(
              future: _slots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new CircularProgressIndicator();
                  default:
                    if (snapshot.hasError) {
                      Text("No available slots");
                    } else {
                      return Column(
                        children: <Widget>[
                          if (snapshot.data['msg'] != null)
                            Text(snapshot.data['msg']),
                          if (snapshot.data['1'] != null)
                            SizedBox(
                              height: 50,
                              width: 150,
                              child: Card(
                                child: InkWell(
                                  onTap: () =>
                                      _next(context, snapshot.data["1"]),
                                  child:
                                      Center(child: Text(snapshot.data["1"])),
                                ),
                              ),
                            ),
                          if (snapshot.data['2'] != null)
                            SizedBox(
                              height: 50,
                              width: 150,
                              child: Card(
                                child: InkWell(
                                  onTap: () =>
                                      _next(context, snapshot.data["2"]),
                                  child:
                                      Center(child: Text(snapshot.data["2"])),
                                ),
                              ),
                            ),
                          if (snapshot.data['3'] != null)
                            SizedBox(
                              height: 50,
                              width: 150,
                              child: Card(
                                child: InkWell(
                                  onTap: () =>
                                      _next(context, snapshot.data["3"]),
                                  child:
                                      Center(child: Text(snapshot.data["3"])),
                                ),
                              ),
                            ),
                          if (snapshot.data['4'] != null)
                            SizedBox(
                              height: 50,
                              width: 150,
                              child: Card(
                                child: InkWell(
                                  onTap: () =>
                                      _next(context, snapshot.data["4"]),
                                  child:
                                      Center(child: Text(snapshot.data["4"])),
                                ),
                              ),
                            ),
                        ],
                      );
                    }
                }
              },
            ),

            // SizedBox(
            //   height: 50,
            //   width: 150,
            //   child: Card(
            //     child: InkWell(
            //       // onTap: () => _next(context, "7s"),
            //       onTap: _slots,
            //       child: Center(child: Text("7s")),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 50,
            //   width: 150,
            //   child: Card(
            //     child: InkWell(
            //       onTap: () => _next(context, "5s A"),
            //       child: Center(child: Text("5s A")),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 50,
            //   width: 150,
            //   child: Card(
            //     child: InkWell(
            //       onTap: () => _next(context, "5s B"),
            //       child: Center(child: Text("5s B")),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
