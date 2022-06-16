import 'dart:convert';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
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
  late String name;
  late String token;
  bool darkMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: darkMode ? Colors.grey[850] : Colors.grey[300],
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Neumorphic(
                  style: NeumorphicStyle(
                    lightSource: LightSource.topLeft,
                    depth: -3,
                    color: Colors.grey[300],
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Color(0xffd9d9d9))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none)),
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future lookup_login() async {
    Map newUpdate = {
      "password": password,
      "username": username,
    };
    final url = Uri.parse(
        "https://production.api.ezygo.app/api/v1/login/lookup?username=+${username}");

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(newUpdate),
    );
    print(json.decode(response.body)["users"].toString());

    name = json.decode(response.body)["users"][0].toString();

    Map newUpdate2 = {
      "password": password,
      "username": name,
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

  Future username_login() async {
    Map newUpdate2 = {
      "password": password,
      "username": username,
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
