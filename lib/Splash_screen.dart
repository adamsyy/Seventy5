import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:seventy5/Home.dart';
import 'package:seventy5/username.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();

  void removeAfter(Future Function(BuildContext? context) initialization) {}
}

class _SplashScreenState extends State<SplashScreen> {

  String api = "https://production.api.ezygo.app/api/v1/Xcr45_salt";

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }


  Future checkLogin() async {
    // Here we check if user already logged in or not
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = await pref.getString("token");
    String? username = await pref.getString("username");
    String? password = await pref.getString("password");

    if(username!=null){
      username_login(username,password.toString());
    }else{
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Username(),),
        (route) => false
      );
    }
  }

  Future username_login(String username,String password) async {
    Map newUpdate2 = {
      "password": password,
      "username": username,
    };
    final url2 = Uri.parse(api+"/login");

    final response2 = await http.post(
      url2,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(newUpdate2),
    );
    // print("res 2");
    // print(response2.body);

    String token=json.decode(response2.body)["access_token"];
    //print("logging in");

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username',username);
    await prefs.setString('password',password);
    await prefs.setString('token',token);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  Home(name: username.toString(),token: token,)),
    );
  }
}
