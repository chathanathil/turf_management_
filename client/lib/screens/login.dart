import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
  var _isLoading = false;
  String _token = "";
  Map<String, String> _authData = {'username': '', 'password': ''};
  Map<String, dynamic> _data = Map<String, dynamic>();

  Future<void> _login() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    const url = 'http://sleepy-falls-05306.herokuapp.com/api/users/login';
    try {
      final response = await http.post(url, body: {
        "username": _authData['username'],
        "password": _authData['password']
      });
      _data = json.decode(response.body);
      if (_data['token'] == null) {
        setState(() {
          _isLoading = false;
        });
        return;
      }
      // Storing token in Shared preference
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt', _data['token']);

      Navigator.of(context).pushReplacementNamed('/dash-board');
      setState(() {
        _isLoading = false;
      });
      return _data['token'];
    } catch (error) {
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          height: deviceSize.height,
          width: deviceSize.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset(
                "assets/logo.png",
                height: 250,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 8,
                child: Container(
                  height: 265,
                  width: deviceSize.width * .75,
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'User name',
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter your user name';
                            }
                          },
                          onSaved: (value) {
                            _authData['username'] = value;
                          },
                        ),
                        if (_data['username'] != null)
                          Container(
                            margin: EdgeInsets.only(top: 10, right: 200),
                            child: Text(
                              _data['username'],
                              style: TextStyle(color: Colors.red, fontSize: 10),
                            ),
                          ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          controller: _passwordController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter your password';
                            }
                          },
                          onSaved: (value) {
                            _authData['password'] = value;
                          },
                        ),
                        if (_data['password'] != null)
                          Container(
                            margin: EdgeInsets.only(top: 10, right: 180),
                            child: Text(
                              _data['password'],
                              style: TextStyle(color: Colors.red, fontSize: 10),
                            ),
                          ),
                        SizedBox(
                          height: 15,
                        ),
                        if (_isLoading)
                          CircularProgressIndicator()
                        else
                          RaisedButton(
                            child: Text("Login"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 8.0),
                            color: Theme.of(context).primaryColor,
                            textColor:
                                Theme.of(context).primaryTextTheme.button.color,
                            onPressed: _login,
                          )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
