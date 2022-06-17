import 'package:flutter/material.dart';
import 'package:seventy5/Home.dart';
import 'package:seventy5/username.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
get_token();
getcred();
  }
  @override
  Widget build(BuildContext context) {

if(token!=null){
  return MaterialApp(home: Home(token: token, name: username,),);
}else {
  return MaterialApp(home: Username(),);
}

  }
getcred()async{

  SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {
    username = prefs.getString('username')!;
    password = prefs.getString('password')!;

  });

}
  get_token()async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token')!;


    });

  }

}

