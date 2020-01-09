import 'package:flutter/material.dart';

class Confirmation extends StatelessWidget {
  static const routeName = '/confirmation';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text("Booking is confirmed"),
        ),
      ),
    );
  }
}
