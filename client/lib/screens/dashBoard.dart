import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turf/widgets/poolBookings.dart';
import 'package:turf/widgets/turfBooking.dart';

class DashBoard extends StatefulWidget {
  static const routeName = '/dash-board';

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  static DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  SharedPreferences sp;
  Future<List<dynamic>> pool() async {
    final url =
        'http://sleepy-falls-05306.herokuapp.com/api/matchs/pool/${DateFormat('dd-MM-yyyy').format(selectedDate)}';
    final cancelUrl =
        'http://sleepy-falls-05306.herokuapp.com/api/cancel/pool/${DateFormat('dd-MM-yyyy').format(selectedDate)}';

    try {
      sp = await SharedPreferences.getInstance();
      final response = await http.get(url,
          headers: {HttpHeaders.authorizationHeader: sp.getString('jwt')});
      final extractData = json.decode(response.body);

      final cancelResponse = await http.get(cancelUrl,
          headers: {HttpHeaders.authorizationHeader: sp.getString('jwt')});
      final cancelExtractData = json.decode(cancelResponse.body);

      if (cancelExtractData == null)
        return extractData;
      else
        return [...extractData, ...cancelExtractData];
    } catch (error) {
      throw error;
    }
  }

  Future<List<dynamic>> teams() async {
    final url =
        'http://sleepy-falls-05306.herokuapp.com/api/matchs/turf/${DateFormat('dd-MM-yyyy').format(selectedDate)}';
    final cancelUrl =
        'http://sleepy-falls-05306.herokuapp.com/api/cancel/turf/${DateFormat('dd-MM-yyyy').format(selectedDate)}';

    try {
      sp = await SharedPreferences.getInstance();
      final response = await http.get(url,
          headers: {HttpHeaders.authorizationHeader: sp.getString('jwt')});
      final extractData = json.decode(response.body);

      final cancelResponse = await http.get(cancelUrl,
          headers: {HttpHeaders.authorizationHeader: sp.getString('jwt')});
      final cancelExtractData = json.decode(cancelResponse.body);

      if (cancelExtractData == null)
        return extractData;
      else
        return [...extractData, ...cancelExtractData];
    } catch (error) {
      throw error;
    }
  }

  void _addMatch() {
    Navigator.of(context).pushNamed("/select-date");
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: _addMatch,
            child: Icon(Icons.add),
          ),
          appBar: AppBar(
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: "Football Turf",
                ),
                Tab(
                  text: "Swimming Pool",
                )
              ],
            ),
            title: Text(
              "Abraj Bookings",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  setState(() {
                    teams();
                    pool();
                  });
                },
              ),
              Container(
                height: 30,
                width: 150,
                margin: const EdgeInsets.only(top: 15, bottom: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
                child: InkWell(
                  onTap: () => _selectDate(context),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        DateFormat('dd/MM/yyyy').format(selectedDate),
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.date_range,
                        size: 20,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          body: TabBarView(
            children: <Widget>[
              Container(
                height: height,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      FutureBuilder(
                        future: teams(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: new CircularProgressIndicator());
                            default:
                              if (snapshot.hasError)
                                return Container(
                                    margin: EdgeInsets.only(top: height / 2.5),
                                    child:
                                        new Text('No bookings in this date'));
                              else {
                                return TurfBooking(
                                  details: snapshot.data,
                                );
                              }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: height,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      FutureBuilder(
                        future: pool(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: new CircularProgressIndicator());
                            default:
                              if (snapshot.hasError)
                                return Container(
                                    margin: EdgeInsets.only(top: height / 2.5),
                                    child:
                                        new Text('No bookings in this date'));
                              else {
                                return PoolBooking(
                                  details: snapshot.data,
                                );
                              }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
