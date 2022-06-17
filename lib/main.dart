import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seventy5/Home.dart';
import 'package:seventy5/username.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String username;
  late String password;
  late String token;
  int check=0;
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
// get_token();
//  getcred();

  }
  @override
  Widget build(BuildContext context) {

  return MaterialApp(home: SplashScreen());







  }
// getcred()async{
//
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   setState(() {
//     username = prefs.getString('username')!;
//     password = prefs.getString('password')!;
//
// if(username==null){
//   check=3;
// }
//   });
//
// }
//   get_token()async{
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       try {
//         token = prefs.getString('token')!;
//
//       }  catch (e) {
//        check=2;
//
//       }
//
// print(token);
//     });
//
//   }
//   void checkLogin() async {
//     // Here we check if user already logged in or not
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     String? token = await pref.getString("token");
//     if (token != null) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) =>  Home(name: "adam",token: token,)),
//       );
//     } else {
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(
//             builder: (context) => Username(),
//           ),
//               (route) => false);
//     }
//   }

}

