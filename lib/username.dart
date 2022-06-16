import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Username extends StatefulWidget {

  @override
  State<Username> createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  late String username;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(

        children: [  SizedBox(height: 100,),

          TextField(
            onChanged: (value){
              username=value;
            },
            obscureText: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'username',
            ),
          ),
          SizedBox(height: 200,),
          TextField(
            obscureText: false,
            onChanged: (value){
              password=value;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
      GestureDetector(onTap: ()async{
        await lookup_login();
      },
        child: Container(color: Colors.pink,height: 100,width: 100,
          child: Text("sett"),
        ),
      )
        ],
      ) ,
    );
  }


  Future lookup_login() async {

    Map newUpdate = {
      "password": password,
      "username":username,
    };
    final url = Uri.parse("https://production.api.ezygo.app/api/v1/login/lookup?username=+${username}");

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(newUpdate),
    );
    print(json.decode(response.body)["users"].toString());

String name=json.decode(response.body)["users"][0].toString();


    Map newUpdate2 = {
      "password": password,
      "username":name,
    };
    final url2 = Uri.parse("https://production.api.ezygo.app/api/v1/login");

    final response2 = await http.post(
      url2,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(newUpdate2),
    );
    print("res 2");
    print(response2.body);




  }

  Future username_login()async{
    Map newUpdate2 = {
      "password": password,
      "username":username,
    };
    final url2 = Uri.parse("https://production.api.ezygo.app/api/v1/login");

    final response2 = await http.post(
      url2,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(newUpdate2),
    );
    print("res 2");
    print(response2.body);




  }

}
