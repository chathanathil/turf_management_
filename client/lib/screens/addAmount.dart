import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddAmount extends StatefulWidget {
  static const routeName = '/addAmount';
  final String id;
  AddAmount({this.id});
  @override
  _AddAmountState createState() => _AddAmountState();
}

class _AddAmountState extends State<AddAmount> {
  final amountController = TextEditingController();
  SharedPreferences sp;
  var _isLoading = false;

  Future<void> _submitAmount(String id) async {
    if (amountController.text.length == 0) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    final url =
        "http://sleepy-falls-05306.herokuapp.com/api/matchs/addAmount/$id";
    try {
      sp = await SharedPreferences.getInstance();
      final response = await http.post(url,
          headers: {HttpHeaders.authorizationHeader: sp.getString('jwt')},
          body: {"amount": amountController.text});
      setState(() {
        _isLoading = false;
        Navigator.pop(context);
      });
    } catch (error) {
      throw (error);
    }
  }

  Future<void> _cancelMatch(String id) async {
    setState(() {
      _isLoading = true;
    });
    final url = "http://sleepy-falls-05306.herokuapp.com/api/cancel/add/$id";
    try {
      sp = await SharedPreferences.getInstance();
      final response = await http.post(
        url,
        headers: {HttpHeaders.authorizationHeader: sp.getString('jwt')},
      );
      setState(() {
        _isLoading = false;
      });
      Navigator.pop(context);
    } catch (error) {
      throw (error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 30),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 90),
                    child: Text(
                      "Received Amount",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        width: 250,
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Amount'),
                          controller: amountController,
                        ),
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 8.0),
                        color: Theme.of(context).primaryColor,
                        textColor:
                            Theme.of(context).primaryTextTheme.button.color,
                        onPressed: () => _submitAmount(widget.id),
                        child: Text("Add"),
                      )
                    ],
                  ),
                ],
              ),
            ),
            if (_isLoading) CircularProgressIndicator(),
            RaisedButton.icon(
              icon: Icon(Icons.delete),
              label: Text("Cancel booking"),
              onPressed: () => _cancelMatch(widget.id),
            )
          ],
        ),
      ),
    );
  }
}
