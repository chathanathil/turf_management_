import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turf/screens/addAmount.dart';

import './screens/dashBoard.dart';
import './screens/teamDetails.dart';
import './screens/confirmation.dart';
import './screens/login.dart';
import './screens/selectDate.dart';
import './screens/selectTime.dart';
import './screens/selectTeam.dart';
import 'screens/dashBoard.dart';
import 'screens/login.dart';

//  main()  {
// WidgetsFlutterBinding.ensureInitialized();
//   runApp(MyApp());}

// class MyApp extends StatelessWidget {
//   // final String token;
//   // MyApp(this.token);
// //  Widget _checkToken() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     final token = prefs.getString('jwt') ?? '';
// //     return token.isEmpty ? Login() : DashBoard();
// //   }

//   @override
//   Widget build(BuildContext context ) {
//     return MaterialApp(
//       title: 'Abraj',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         accentColor: Colors.blue,
//       ),
//       home: _checkToken(),
//       routes: {
//         DashBoard.routeName: (ctx) => DashBoard(),
//         SelectDate.routeName: (ctx) => SelectDate(),
//         AddAmount.routeName: (ctx) => AddAmount()
//         // SelectTime.routeName: (ctx) => SelectTime(),
//         // SelectTeam.routeName: (ctx) => SelectTeam(),
//         // TeamDetails.routeName: (ctx) => TeamDetails(),
//         // Confirmation.routeName: (ctx) => Confirmation()
//       },
//     );
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final jwtToken = prefs.getString('jwt') ?? '';
  runApp(MaterialApp(
    title: "Abraj",
    home: Screen(jwtToken),
    routes: {
      DashBoard.routeName: (ctx) => DashBoard(),
      SelectDate.routeName: (ctx) => SelectDate(),
      AddAmount.routeName: (ctx) => AddAmount()
      // SelectTime.routeName: (ctx) => SelectTime(),
      // SelectTeam.routeName: (ctx) => SelectTeam(),
      // TeamDetails.routeName: (ctx) => TeamDetails(),
      // Confirmation.routeName: (ctx) => Confirmation()
    },
  ));
}

class Screen extends StatelessWidget {
  final String token;
  // Screen(aToken) {
  //   token = aToken;
  // }
  Screen(this.token);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: token.isEmpty ? Login() : DashBoard(),
    );
  }
}
