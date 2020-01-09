import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turf/screens/addAmount.dart';

class PoolBooking extends StatefulWidget {
  final List<dynamic> details;

  PoolBooking({this.details});

  @override
  _PoolBookingState createState() => _PoolBookingState();
}

class _PoolBookingState extends State<PoolBooking> {
  final amountController = TextEditingController();
  var total = 0;
  SharedPreferences sp;

  _createSlot() {
    List<Widget> slot = List();
    widget.details.forEach((item) {
      slot.add(
        Card(
          elevation: 1,
          margin: EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: (item['cancelled']) == true
                        ? Colors.red
                        : Colors.white)),
            child: InkWell(
              onDoubleTap: () => Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new AddAmount(
                    id: item['_id'],
                  ),
                ),
              ),
              child: ListTile(
                leading: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(item['time'])),
                title: Text(item['name']),
                subtitle: InkWell(child: SelectableText(item['phone'])),
                trailing: Container(
                    width: 180,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Created By"),
                            Text(item['createdBy']),
                          ],
                        ),
                        if (item['amount'] != null)
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Amount"),
                                Text(item['amount'].toString())
                              ]),
                        Text(item['team']),
                      ],
                    )),
              ),
            ),
          ),
        ),
      );
    });
    return slot;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _createSlot(),
    );
  }
}
