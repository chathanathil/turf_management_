import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TeamDetails extends StatefulWidget {
  static const routeName = '/team-details';
  final String date;
  final String time;
  final String team;
  TeamDetails({this.date, this.time, this.team});

  @override
  _TeamDetailsState createState() => _TeamDetailsState();
}

class _TeamDetailsState extends State<TeamDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _teamData = {"name": "", "phone": "", "createdBy": ""};
  var _isLoading = false;
  SharedPreferences sp;

  Future<void> _onSubmit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    setState(() {
      _isLoading = true;
    });
    final url = "http://sleepy-falls-05306.herokuapp.com/api/matchs/add";
    try {
      sp = await SharedPreferences.getInstance();
      final response = await http.post(url, headers: {
        HttpHeaders.authorizationHeader: sp.getString("jwt")
      }, body: {
        "date": widget.date,
        "time": widget.time,
        "team": widget.team,
        "name": _teamData["name"],
        "phone": _teamData["phone"],
        "createdBy": _teamData["createdBy"]
      });
      print(response.body);
      Navigator.popUntil(context, ModalRoute.withName('/select-date'));
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Congratulation"),
            content: new Text("Your Booking is confirmed..!!"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/dash-board');
                },
              ),
            ],
          );
        },
      );
    } catch (error) {
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Team Details",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15, bottom: 15),
                    width: 300,
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Name', border: OutlineInputBorder()),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Name of the team';
                        }
                      },
                      onSaved: (value) {
                        _teamData['name'] = value;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Phone', border: OutlineInputBorder()),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Phone number of the team';
                        }
                      },
                      onSaved: (value) {
                        _teamData['phone'] = value;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15, bottom: 15),
                    width: 300,
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Created By',
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter your name';
                        }
                      },
                      onSaved: (value) {
                        _teamData['createdBy'] = value;
                      },
                    ),
                  ),
                  if (_isLoading)
                    CircularProgressIndicator()
                  else
                    RaisedButton(
                      child: Text("Submit"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                      color: Theme.of(context).primaryColor,
                      textColor:
                          Theme.of(context).primaryTextTheme.button.color,
                      onPressed: _onSubmit,
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
