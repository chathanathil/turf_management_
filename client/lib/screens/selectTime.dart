import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'selectTeam.dart';

class SelectTime extends StatelessWidget {
  static const routeName = "/select-time";
  final String date;
  SelectTime({this.date});
  SharedPreferences sp;

  get http => null;

  void _next(BuildContext context, String time) {
    Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => new SelectTeam(date: date, time: time),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    "Select time",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Wrap(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: Card(
                        child: InkWell(
                          onTap: () => _next(context, "6am to 7 am"),
                          child: Center(child: Text("6am to 7am")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: Card(
                        child: InkWell(
                          onTap: () => _next(context, "7am to 8am"),
                          child: Center(child: Text("7am to 8am")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: Card(
                        child: InkWell(
                          onTap: () => _next(context, "8am to 9am"),
                          child: Center(child: Text("8am to 9am")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: Card(
                        child: InkWell(
                          onTap: () => _next(context, "9am to 10am"),
                          child: Center(child: Text("9am to 10am")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: Card(
                        child: InkWell(
                          onTap: () => _next(context, "10am to 11am"),
                          child: Center(child: Text("10am to 11am")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: Card(
                        child: InkWell(
                          onTap: () => _next(context, "11am to 12pm"),
                          child: Center(child: Text("11am to 12pm")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: Card(
                        child: InkWell(
                          onTap: () => _next(context, "12pm to 1pm"),
                          child: Center(child: Text("12pm to 1pm")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: Card(
                        child: InkWell(
                          onTap: () => _next(context, "1pm to 2pm"),
                          child: Center(child: Text("1pm to 2pm")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: Card(
                        child: InkWell(
                          onTap: () => _next(context, "2pm to 3pm"),
                          child: Center(child: Text("2pm to 3pm")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: Card(
                        child: InkWell(
                          onTap: () => _next(context, "3pm to 4pm"),
                          child: Center(child: Text("3pm to 4pm")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: Card(
                        child: InkWell(
                          onTap: () => _next(context, "4pm to 5pm"),
                          child: Center(child: Text("4pm to 5pm")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: Card(
                        child: InkWell(
                          onTap: () => _next(context, "5pm to 6pm"),
                          child: Center(child: Text("5pm to 6pm")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: Card(
                        child: InkWell(
                          onTap: () => _next(context, "6pm to 7pm"),
                          child: Center(child: Text("6pm to 7pm")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: Card(
                        child: InkWell(
                          onTap: () => _next(context, "7pm to 8pm"),
                          child: Center(child: Text("7pm to 8pm")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: Card(
                        child: InkWell(
                          onTap: () => _next(context, "8pm to 9pm"),
                          child: Center(child: Text("8pm to 9pm")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: Card(
                        child: InkWell(
                          onTap: () => _next(context, "9pm to 10pm"),
                          child: Center(child: Text("9pm to 10pm")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: Card(
                        child: InkWell(
                          onTap: () => _next(context, "10pm to 11pm"),
                          child: Center(child: Text("10pm to 11pm")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: Card(
                        child: InkWell(
                          onTap: () => _next(context, "11pm to 12am"),
                          child: Center(child: Text("11pm to 12am")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: Card(
                        child: InkWell(
                          onTap: () => _next(context, "12am to 1am"),
                          child: Center(child: Text("12am to 1am")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: Card(
                        child: InkWell(
                          onTap: () => _next(context, "1am to 2am"),
                          child: Center(child: Text("1am to 2am")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: Card(
                        child: InkWell(
                          onTap: () => _next(context, "2am to 3am"),
                          child: Center(child: Text("2am to 3am")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: Card(
                        child: InkWell(
                          onTap: () => _next(context, "3am to 4am"),
                          child: Center(child: Text("3am to 4am")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: Card(
                        child: InkWell(
                          onTap: () => _next(context, "4am to 5am"),
                          child: Center(child: Text("4am to 5am")),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: Card(
                        child: InkWell(
                          onTap: () => _next(context, "5am to 6am"),
                          child: Center(child: Text("5am to 6am")),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
